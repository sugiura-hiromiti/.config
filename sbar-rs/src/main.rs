mod config;
mod helpers;
mod items;
mod sketchybar;

use anyhow::Result;
use signal_hook::consts::SIGTERM;
use signal_hook_tokio::Signals;
use std::collections::HashMap;
use std::sync::Arc;
use tokio::sync::{broadcast, RwLock};
use tokio::time::{interval, Duration};
use tracing::{error, info, warn};
use futures::stream::StreamExt;

use helpers::yabai::DisplayInfo;
use sketchybar::SketchyBar;

/// Main daemon state
#[derive(Debug)]
pub struct SketchyBarDaemon {
    displays: Arc<RwLock<HashMap<String, DisplayInfo>>>,
    bars: Arc<RwLock<HashMap<String, SketchyBar>>>,
    shutdown_tx: broadcast::Sender<()>,
}

impl SketchyBarDaemon {
    pub fn new() -> Self {
        let (shutdown_tx, _) = broadcast::channel(1);
        
        Self {
            displays: Arc::new(RwLock::new(HashMap::new())),
            bars: Arc::new(RwLock::new(HashMap::new())),
            shutdown_tx,
        }
    }

    /// Start the daemon
    pub async fn run(&mut self) -> Result<()> {
        info!("🦀 Starting SketchyBar Daemon v0.2.0");

        // Setup signal handling
        let mut signals = Signals::new(&[SIGTERM])?;
        let shutdown_tx = self.shutdown_tx.clone();
        
        tokio::spawn(async move {
            while let Some(signal) = signals.next().await {
                match signal {
                    SIGTERM => {
                        info!("📡 Received SIGTERM, shutting down gracefully");
                        let _ = shutdown_tx.send(());
                        break;
                    }
                    _ => {}
                }
            }
        });

        // Initial display detection and bar setup
        self.detect_and_setup_displays().await?;

        // Start display monitoring
        let daemon_clone = Arc::new(RwLock::new(self.clone()));
        let monitor_task = tokio::spawn(Self::monitor_displays(daemon_clone));

        // Start update loops for all items
        let update_task = tokio::spawn(Self::run_update_loops(
            self.bars.clone(),
            self.shutdown_tx.subscribe(),
        ));

        // Wait for shutdown signal or task completion
        let mut shutdown_rx = self.shutdown_tx.subscribe();
        tokio::select! {
            _ = shutdown_rx.recv() => {
                info!("🛑 Shutdown signal received");
            }
            result = monitor_task => {
                if let Err(e) = result {
                    error!("❌ Display monitor task failed: {}", e);
                }
            }
            result = update_task => {
                if let Err(e) = result {
                    error!("❌ Update task failed: {}", e);
                }
            }
        }

        info!("✅ SketchyBar Daemon shutdown complete");
        Ok(())
    }

    /// Detect displays and setup bars
    async fn detect_and_setup_displays(&mut self) -> Result<()> {
        let new_displays = helpers::yabai::get_displays().await?;
        let mut displays = self.displays.write().await;
        let mut bars = self.bars.write().await;

        info!("📺 Detected {} displays", new_displays.len());

        // Remove bars for displays that no longer exist
        let mut to_remove = Vec::new();
        for display_id in displays.keys() {
            if !new_displays.contains_key(display_id) {
                to_remove.push(display_id.clone());
            }
        }

        for display_id in to_remove {
            info!("🗑️  Removing bar for disconnected display {}", display_id);
            displays.remove(&display_id);
            bars.remove(&display_id);
        }

        // Add bars for new displays
        for (display_id, display_info) in new_displays.iter() {
            if !displays.contains_key(display_id) {
                info!("🚀 Setting up bar for new display {}", display_id);
                
                let bar_name = if display_info.is_builtin {
                    "sketchybar".to_string()
                } else {
                    format!("external_{}", display_info.index)
                };

                let mut bar = SketchyBar::new();
                bar.set_bar_name(&bar_name);

                // Configure the bar
                if let Err(e) = config::setup_bar(&mut bar, &bar_name, display_info).await {
                    error!("❌ Failed to configure bar {}: {}", bar_name, e);
                    continue;
                }

                // Add all items
                if let Err(e) = items::setup_all_items(&mut bar, display_info).await {
                    error!("❌ Failed to setup items for bar {}: {}", bar_name, e);
                    continue;
                }

                // Enable hotloading
                if let Err(e) = bar.hotload(true).await {
                    warn!("⚠️  Failed to enable hotloading for bar {}: {}", bar_name, e);
                }

                bars.insert(display_id.clone(), bar);
                info!("✅ Bar '{}' configured for display {}", bar_name, display_id);
            }
        }

        *displays = new_displays;
        Ok(())
    }

    /// Monitor displays for changes
    async fn monitor_displays(daemon: Arc<RwLock<Self>>) -> Result<()> {
        let mut interval = interval(Duration::from_secs(5));
        
        loop {
            interval.tick().await;
            
            let mut daemon_guard = daemon.write().await;
            if let Err(e) = daemon_guard.detect_and_setup_displays().await {
                error!("❌ Display detection failed: {}", e);
            }
        }
    }

    /// Run update loops for all bar items
    async fn run_update_loops(
        bars: Arc<RwLock<HashMap<String, SketchyBar>>>,
        mut shutdown_rx: broadcast::Receiver<()>,
    ) -> Result<()> {
        // Clock update task (every second)
        let bars_clock = bars.clone();
        let mut shutdown_clock = shutdown_rx.resubscribe();
        let clock_task = tokio::spawn(async move {
            let mut timer = interval(Duration::from_secs(1));
            
            loop {
                tokio::select! {
                    _ = timer.tick() => {
                        let bars_guard = bars_clock.read().await;
                        for bar in bars_guard.values() {
                            if let Err(e) = items::clock::update(bar).await {
                                error!("❌ Clock update error: {}", e);
                            }
                        }
                    }
                    _ = shutdown_clock.recv() => {
                        info!("🕐 Clock update task shutting down");
                        break;
                    }
                }
            }
        });

        // Battery update task (every 30 seconds)
        let bars_battery = bars.clone();
        let mut shutdown_battery = shutdown_rx.resubscribe();
        let battery_task = tokio::spawn(async move {
            let mut timer = interval(Duration::from_secs(30));
            
            loop {
                tokio::select! {
                    _ = timer.tick() => {
                        let bars_guard = bars_battery.read().await;
                        for bar in bars_guard.values() {
                            if let Err(e) = items::battery::update(bar).await {
                                error!("❌ Battery update error: {}", e);
                            }
                        }
                    }
                    _ = shutdown_battery.recv() => {
                        info!("🔋 Battery update task shutting down");
                        break;
                    }
                }
            }
        });

        // Keyboard update task (every 5 seconds)
        let bars_keyboard = bars.clone();
        let mut shutdown_keyboard = shutdown_rx.resubscribe();
        let keyboard_task = tokio::spawn(async move {
            let mut timer = interval(Duration::from_secs(5));
            
            loop {
                tokio::select! {
                    _ = timer.tick() => {
                        let bars_guard = bars_keyboard.read().await;
                        for bar in bars_guard.values() {
                            if let Err(e) = items::keyboard::update(bar).await {
                                error!("❌ Keyboard update error: {}", e);
                            }
                        }
                    }
                    _ = shutdown_keyboard.recv() => {
                        info!("⌨️  Keyboard update task shutting down");
                        break;
                    }
                }
            }
        });

        // Space update task (every 2 seconds)
        let bars_space = bars.clone();
        let mut shutdown_space = shutdown_rx.resubscribe();
        let space_task = tokio::spawn(async move {
            let mut timer = interval(Duration::from_secs(2));
            
            loop {
                tokio::select! {
                    _ = timer.tick() => {
                        let bars_guard = bars_space.read().await;
                        for bar in bars_guard.values() {
                            if let Err(e) = items::space::update(bar).await {
                                error!("❌ Space update error: {}", e);
                            }
                        }
                    }
                    _ = shutdown_space.recv() => {
                        info!("🏠 Space update task shutting down");
                        break;
                    }
                }
            }
        });

        // Current app update task (every 3 seconds)
        let bars_app = bars.clone();
        let mut shutdown_app = shutdown_rx.resubscribe();
        let app_task = tokio::spawn(async move {
            let mut timer = interval(Duration::from_secs(3));
            
            loop {
                tokio::select! {
                    _ = timer.tick() => {
                        let bars_guard = bars_app.read().await;
                        for bar in bars_guard.values() {
                            if let Err(e) = items::current_app::update(bar).await {
                                error!("❌ Current app update error: {}", e);
                            }
                        }
                    }
                    _ = shutdown_app.recv() => {
                        info!("📱 Current app update task shutting down");
                        break;
                    }
                }
            }
        });

        // Window update task (every 3 seconds)
        let bars_window = bars.clone();
        let mut shutdown_window = shutdown_rx.resubscribe();
        let window_task = tokio::spawn(async move {
            let mut timer = interval(Duration::from_secs(3));
            
            loop {
                tokio::select! {
                    _ = timer.tick() => {
                        let bars_guard = bars_window.read().await;
                        for bar in bars_guard.values() {
                            if let Err(e) = items::window::update(bar).await {
                                error!("❌ Window update error: {}", e);
                            }
                        }
                    }
                    _ = shutdown_window.recv() => {
                        info!("🪟 Window update task shutting down");
                        break;
                    }
                }
            }
        });

        // Wait for shutdown or task completion
        tokio::select! {
            _ = shutdown_rx.recv() => {
                info!("🛑 Update loops shutting down");
            }
            result = clock_task => {
                if let Err(e) = result {
                    error!("❌ Clock task error: {}", e);
                }
            }
            result = battery_task => {
                if let Err(e) = result {
                    error!("❌ Battery task error: {}", e);
                }
            }
            result = keyboard_task => {
                if let Err(e) = result {
                    error!("❌ Keyboard task error: {}", e);
                }
            }
            result = space_task => {
                if let Err(e) = result {
                    error!("❌ Space task error: {}", e);
                }
            }
            result = app_task => {
                if let Err(e) = result {
                    error!("❌ App task error: {}", e);
                }
            }
            result = window_task => {
                if let Err(e) = result {
                    error!("❌ Window task error: {}", e);
                }
            }
        }

        Ok(())
    }
}

impl Clone for SketchyBarDaemon {
    fn clone(&self) -> Self {
        Self {
            displays: self.displays.clone(),
            bars: self.bars.clone(),
            shutdown_tx: self.shutdown_tx.clone(),
        }
    }
}

#[tokio::main]
async fn main() -> Result<()> {
    // Initialize tracing
    tracing_subscriber::fmt()
        .with_env_filter(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| "info".into())
        )
        .init();

    // Create and run daemon
    let mut daemon = SketchyBarDaemon::new();
    daemon.run().await
}
