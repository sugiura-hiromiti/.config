mod config;
mod helpers;
mod items;
mod sketchybar;

use anyhow::Result;
use sketchybar::SketchyBar;
use tokio::task::JoinHandle;

#[tokio::main]
async fn main() -> Result<(),> {
	println!("🦀 Starting Rusty Sbar...");

	// Get display information
	let displays = helpers::yabai::get_displays().await?;
	println!("📺 Found {} displays", displays.len());

	let mut handles: Vec<JoinHandle<Result<(),>,>,> = Vec::new();

	// Create bars for each display
	for (display_id, display_info,) in displays {
		let bar_name = if display_info.is_builtin {
			"sketchybar".to_string()
		} else {
			format!("external_{}", display_info.index)
		};

		println!("🚀 Launching bar '{}' for display {}", bar_name, display_id);

		let handle = tokio::spawn(async move { run_bar(bar_name, display_info,).await },);

		handles.push(handle,);
	}

	// Wait for all bars (they should run indefinitely)
	for handle in handles {
		if let Err(e,) = handle.await? {
			eprintln!("❌ Bar crashed: {}", e);
		}
	}

	Ok((),)
}

/// Run a single SketchyBar instance for a specific display
async fn run_bar(bar_name: String, display_info: helpers::yabai::DisplayInfo,) -> Result<(),> {
	let mut bar = SketchyBar::new();

	// Set bar name
	bar.set_bar_name(&bar_name,);

	// Configure the bar
	config::setup_bar(&mut bar, &bar_name, &display_info,).await?;

	// Add all items
	items::setup_all_items(&mut bar, &display_info,).await?;

	// Enable hotloading
	bar.hotload(true,).await?;

	println!("✅ Bar '{}' configured and running", bar_name);

	// Start event loop
	bar.event_loop().await?;

	Ok((),)
}
