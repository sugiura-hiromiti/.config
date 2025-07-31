# SketchyBar Daemon 🦀

A complete SketchyBar configuration daemon written in Rust. This project provides a standalone, type-safe alternative to shell script-based SketchyBar configurations with real-time updates and multi-display support.

## Features

- **🔄 Standalone Daemon**: Runs as a background service, no shell scripts needed
- **📺 Multi-display Support**: Automatically detects and configures bars for builtin and external displays
- **🔄 Dynamic Display Detection**: Monitors for display changes and reconfigures bars automatically
- **⚡ Real-time Updates**: Live updates for all bar items with configurable intervals
- **🛡️ Type Safety**: Leverages Rust's type system to prevent configuration errors
- **🔧 Modular Architecture**: Clean separation of concerns with dedicated modules
- **📊 Comprehensive Logging**: Structured logging with tracing for debugging
- **🎨 Catppuccin Theme**: Beautiful color scheme matching your existing setup
- **🔋 Smart Battery Monitoring**: Battery indicator with charging status and color coding
- **🏠 Workspace Management**: Space indicators with yabai integration
- **🕐 Live Clock**: Real-time clock with custom formatting
- **⌨️ Keyboard Layout**: Current input source display
- **📱 App/Window Tracking**: Current application and window information

## Architecture

### Core Components

```
src/
├── main.rs              # Daemon entry point and orchestration
├── sketchybar.rs        # High-level SketchyBar API wrapper
├── config/              # Bar configuration
│   └── mod.rs          # Bar and default property setup
├── items/               # Individual bar items with update functions
│   ├── mod.rs          # Item orchestration
│   ├── clock.rs        # Time display with real-time updates
│   ├── battery.rs      # Battery status with smart monitoring
│   ├── keyboard.rs     # Input source detection
│   ├── space.rs        # Workspace indicators with yabai integration
│   ├── current_app.rs  # Active application tracking
│   └── window.rs       # Window information display
└── helpers/             # Utility modules
    ├── mod.rs          # Helper module exports
    ├── yabai.rs        # Display detection and yabai integration
    ├── colors.rs       # Catppuccin color palette
    ├── icons.rs        # Nerd Font icon constants
    └── properties.rs   # Configuration property builders
```

### Design Decisions

1. **Daemon Architecture**: The application runs as a standalone daemon that directly communicates with SketchyBar, eliminating the need for shell scripts and providing better performance and reliability.

2. **Dynamic Display Management**: The daemon continuously monitors for display changes and automatically configures/removes bars as displays are connected/disconnected.

3. **Async Update System**: Each bar item has its own update function that runs on configurable intervals, allowing for efficient real-time updates without blocking.

4. **Graceful Error Handling**: Individual item update failures don't crash the entire daemon, ensuring maximum uptime.

5. **Multi-bar Support**: Each display gets its own SketchyBar instance with display-specific configuration.

6. **Type-safe Configuration**: All configuration is done through Rust structs with proper types, preventing common configuration errors.

## Installation

### Prerequisites

- macOS with SketchyBar installed (`brew install sketchybar`)
- Rust toolchain (`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`)
- yabai (optional, for multi-display and workspace support)
- MesloLGL Nerd Font (for icons)

### Quick Setup

1. **Clone and build the project:**
   ```bash
   cd ~/.config
   git clone <your-repo> sbar-rs
   cd sbar-rs
   cargo build --release
   ```

2. **Install the daemon:**
   ```bash
   # Copy binary to a system location
   sudo cp target/release/sketchybar-daemon /usr/local/bin/
   
   # Or create a symlink
   ln -sf ~/.config/sbar-rs/target/release/sketchybar-daemon /usr/local/bin/sketchybar-daemon
   ```

3. **Create SketchyBar configuration:**
   ```bash
   # Create sketchybarrc that launches the daemon
   mkdir -p ~/.config/sketchybar
   cat > ~/.config/sketchybar/sketchybarrc << 'EOF'
   #!/bin/bash
   # Kill any existing daemon
   pkill -f sketchybar-daemon
   
   # Start the Rust daemon
   exec /usr/local/bin/sketchybar-daemon
   EOF
   chmod +x ~/.config/sketchybar/sketchybarrc
   ```

4. **Start SketchyBar:**
   ```bash
   brew services restart sketchybar
   ```

### Advanced Setup with LaunchAgent

For automatic startup and better process management:

1. **Create LaunchAgent plist:**
   ```bash
   mkdir -p ~/Library/LaunchAgents
   cat > ~/Library/LaunchAgents/com.sketchybar.daemon.plist << 'EOF'
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>Label</key>
       <string>com.sketchybar.daemon</string>
       <key>ProgramArguments</key>
       <array>
           <string>/usr/local/bin/sketchybar-daemon</string>
       </array>
       <key>RunAtLoad</key>
       <true/>
       <key>KeepAlive</key>
       <true/>
       <key>StandardOutPath</key>
       <string>/tmp/sketchybar-daemon.log</string>
       <key>StandardErrorPath</key>
       <string>/tmp/sketchybar-daemon.error.log</string>
   </dict>
   </plist>
   EOF
   ```

2. **Load the LaunchAgent:**
   ```bash
   launchctl load ~/Library/LaunchAgents/com.sketchybar.daemon.plist
   ```

3. **Update SketchyBar config to use the service:**
   ```bash
   cat > ~/.config/sketchybar/sketchybarrc << 'EOF'
   #!/bin/bash
   # The daemon is managed by LaunchAgent
   # This script just ensures SketchyBar is ready
   exit 0
   EOF
   ```

## Configuration

### Update Intervals

The daemon uses different update intervals for different items:

- **Clock**: 1 second (real-time)
- **Battery**: 30 seconds (power efficient)
- **Keyboard**: 5 seconds (responsive to changes)
- **Spaces**: 2 seconds (workspace changes)
- **Current App**: 3 seconds (app switching)
- **Window**: 3 seconds (window changes)

### Display Configuration

The daemon automatically configures different properties based on display type:

| Property | Builtin Display | External Display |
|----------|----------------|------------------|
| Position | Top | Bottom |
| Height | 56px | 26px |
| Font Size | 16px | 14px |
| Padding | 4px | 2px |
| Corner Radius | 10px | 5px |

### Color Scheme

Uses the Catppuccin color palette:

- **Background**: Surface0 (`0xff313244`)
- **Text**: Text (`0xffcdd6f4`)
- **Accent Colors**: Blue, Green, Yellow, Red based on context
- **Battery**: Color-coded based on charge level and status

## Usage

### Running the Daemon

```bash
# Run directly
sketchybar-daemon

# Run with debug logging
RUST_LOG=debug sketchybar-daemon

# Run with trace logging (very verbose)
RUST_LOG=trace sketchybar-daemon
```

### Monitoring

```bash
# Check if daemon is running
pgrep -f sketchybar-daemon

# View logs (if using LaunchAgent)
tail -f /tmp/sketchybar-daemon.log

# View error logs
tail -f /tmp/sketchybar-daemon.error.log
```

### Stopping

```bash
# Stop the daemon
pkill -f sketchybar-daemon

# Or if using LaunchAgent
launchctl unload ~/Library/LaunchAgents/com.sketchybar.daemon.plist
```

## Development

### Building

```bash
# Debug build
cargo build

# Release build (optimized)
cargo build --release

# Check for errors without building
cargo check
```

### Testing

```bash
# Run with debug output
RUST_LOG=debug cargo run

# Test specific functionality
cargo test
```

### Adding New Items

1. Create a new file in `src/items/` (e.g., `cpu.rs`)
2. Implement `setup()` and `update()` functions
3. Add the module to `src/items/mod.rs`
4. Add setup call in `setup_all_items()`
5. Add update task in `run_update_loops()`

Example:
```rust
// src/items/cpu.rs
use anyhow::Result;
use crate::sketchybar::SketchyBar;
use crate::helpers::{colors::Colors, yabai::DisplayInfo};

pub async fn setup(bar: &mut SketchyBar, display_info: &DisplayInfo) -> Result<()> {
    bar.add("item", "cpu", "right").await?;
    bar.set("cpu", &[
        ("icon", "💻"),
        ("label", "CPU"),
        ("label.color", &format!("0x{:08x}", Colors::GREEN)),
    ]).await?;
    Ok(())
}

pub async fn update(bar: &SketchyBar) -> Result<()> {
    // Get CPU usage and update the item
    let usage = get_cpu_usage().await?;
    let cmd = format!("--set cpu label={}%", usage);
    bar.message(&cmd).await?;
    Ok(())
}
```

### Customizing Colors

Modify `src/helpers/colors.rs`:

```rust
impl Colors {
    pub const SURFACE0: u32 = 0xff313244; // Change background color
    pub const TEXT: u32 = 0xffcdd6f4;     // Change text color
    // ... other colors
}
```

### Customizing Update Intervals

Modify the intervals in `src/main.rs` in the `run_update_loops()` function:

```rust
// Change clock update to 5 seconds instead of 1
let mut timer = interval(Duration::from_secs(5));
```

## Troubleshooting

### Common Issues

1. **Daemon won't start**
   - Check if SketchyBar is installed: `brew list sketchybar`
   - Verify binary permissions: `ls -la /usr/local/bin/sketchybar-daemon`
   - Check logs: `RUST_LOG=debug sketchybar-daemon`

2. **Items not updating**
   - Check if yabai is running (for spaces/app/window items)
   - Verify system permissions for AppleScript
   - Check error logs for specific item failures

3. **Multiple displays not working**
   - Install yabai: `brew install yabai`
   - Check yabai is running: `yabai -m query --displays`
   - Verify display detection: `RUST_LOG=debug sketchybar-daemon`

4. **High CPU usage**
   - Reduce update intervals in the code
   - Check for infinite loops in update functions
   - Monitor with: `top -p $(pgrep sketchybar-daemon)`

### Debug Mode

Run with full debug logging:

```bash
RUST_LOG=trace sketchybar-daemon 2>&1 | tee debug.log
```

### Performance Monitoring

```bash
# Monitor resource usage
top -p $(pgrep sketchybar-daemon)

# Check memory usage
ps -o pid,vsz,rss,comm -p $(pgrep sketchybar-daemon)
```

## Comparison with Shell Scripts

| Feature | Shell Scripts | Rust Daemon |
|---------|---------------|-------------|
| **Performance** | Slower (process spawning) | Faster (single process) |
| **Memory Usage** | Higher (multiple processes) | Lower (single process) |
| **Error Handling** | Basic | Comprehensive |
| **Type Safety** | None | Full Rust type system |
| **Real-time Updates** | Difficult | Built-in |
| **Multi-display** | Manual setup | Automatic |
| **Debugging** | Limited | Structured logging |
| **Maintenance** | Script management | Single binary |

## Future Enhancements

1. **Configuration File**: TOML/YAML configuration for easier customization
2. **Plugin System**: Dynamic loading of custom items
3. **Hot Reloading**: Configuration changes without restart
4. **Performance Metrics**: Built-in performance monitoring
5. **Theme System**: Multiple color schemes
6. **Widget Library**: Pre-built widgets for common use cases
7. **Event System**: More sophisticated event handling
8. **Web Interface**: Browser-based configuration and monitoring

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Add tests if applicable
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Acknowledgments

- [SketchyBar](https://github.com/FelixKratz/SketchyBar) - The amazing macOS status bar
- [sketchybar-rs](https://github.com/FelixKratz/sketchybar-rs) - Rust bindings for SketchyBar
- [Catppuccin](https://github.com/catppuccin/catppuccin) - The beautiful color scheme
- [yabai](https://github.com/koekeishiya/yabai) - Tiling window manager for macOS
