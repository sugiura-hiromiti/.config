# Rusty Sbar 🦀

A complete SketchyBar configuration written in Rust using the `sketchybar-rs` crate. This project provides a modular, type-safe alternative to Lua-based SketchyBar configurations.

## Features

- **Multi-display support**: Automatically detects and configures bars for builtin and external displays
- **Modular architecture**: Clean separation of concerns with dedicated modules for items, helpers, and configuration
- **Type safety**: Leverages Rust's type system to prevent configuration errors
- **Async/await**: Modern async programming for responsive UI updates
- **Catppuccin theme**: Beautiful color scheme matching your existing setup
- **Battery monitoring**: Smart battery indicator with charging status and color coding
- **Space management**: Workspace indicators for yabai integration
- **Clock display**: Real-time clock with custom formatting
- **Keyboard layout**: Current input source display
- **Window/app tracking**: Current application and window information

## Architecture

### Core Components

```
src/
├── main.rs              # Entry point and multi-bar orchestration
├── sketchybar.rs        # High-level SketchyBar API wrapper
├── config/              # Bar configuration
│   └── mod.rs          # Bar and default property setup
├── items/               # Individual bar items
│   ├── mod.rs          # Item orchestration
│   ├── clock.rs        # Time display
│   ├── battery.rs      # Battery status
│   ├── keyboard.rs     # Input source
│   ├── space.rs        # Workspace indicators
│   ├── current_app.rs  # Active application
│   └── window.rs       # Window information
└── helpers/             # Utility modules
    ├── mod.rs          # Helper module exports
    ├── yabai.rs        # Display detection and yabai integration
    ├── colors.rs       # Catppuccin color palette
    ├── icons.rs        # Nerd Font icon constants
    └── properties.rs   # Configuration property builders
```

### Design Decisions

1. **High-level API Wrapper**: Since `sketchybar-rs` only provides a low-level `message()` function, we built a high-level `SketchyBar` struct that provides convenient methods like `bar()`, `add()`, `set()`, etc.

2. **Multi-bar Architecture**: The main function spawns separate async tasks for each display, allowing independent configuration and operation of multiple bars.

3. **Display-aware Configuration**: Properties are dynamically adjusted based on whether the display is builtin (larger, top position) or external (smaller, bottom position).

4. **Modular Items**: Each bar item is implemented as a separate module with its own `setup()` function, making it easy to add, remove, or modify individual components.

5. **Type-safe Properties**: Configuration properties are defined as structs with proper types, preventing common configuration errors.

## Setup Instructions

### Prerequisites

- macOS with SketchyBar installed
- Rust nightly toolchain
- yabai (optional, for multi-display support)
- MesloLGL Nerd Font (for icons)

### Installation

1. **Clone and build the project:**
   ```bash
   cd ~/.config
   git clone <your-repo> sbar-rs
   cd sbar-rs
   cargo build --release
   ```

2. **Create a SketchyBar configuration file:**
   ```bash
   # Create sketchybarrc that launches the Rust binary
   echo '#!/bin/bash' > ~/.config/sketchybar/sketchybarrc
   echo 'exec ~/.config/sbar-rs/target/release/sketchybar-config' >> ~/.config/sketchybar/sketchybarrc
   chmod +x ~/.config/sketchybar/sketchybarrc
   ```

3. **Restart SketchyBar:**
   ```bash
   brew services restart sketchybar
   ```

### Configuration Comparison

This Rust implementation reproduces your original Lua configuration:

| Lua Original | Rust Implementation |
|--------------|-------------------|
| `actor/startup.lua` | `items/mod.rs::setup_all_items()` |
| `actor/helper/property.lua` | `helpers/properties.rs` |
| `actor/helper/color.lua` | `helpers/colors.rs` |
| `actor/helper/icon.lua` | `helpers/icons.rs` |
| `actor/helper/yabai.lua` | `helpers/yabai.rs` |
| `actor/item/clock.lua` | `items/clock.rs` |
| `actor/item/battery.lua` | `items/battery.rs` |
| `external_1` & `builtin` | Multi-bar logic in `main.rs` |

### Key Improvements

1. **Type Safety**: Compile-time checking prevents configuration errors
2. **Better Error Handling**: Comprehensive error handling with `anyhow`
3. **Async Architecture**: Non-blocking operations for better responsiveness
4. **Memory Safety**: Rust's ownership system prevents memory leaks
5. **Performance**: Compiled binary is faster than interpreted Lua

## Development

### Adding New Items

1. Create a new file in `src/items/` (e.g., `cpu.rs`)
2. Implement the `setup()` function
3. Add the module to `src/items/mod.rs`
4. Call the setup function in `setup_all_items()`

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
```

### Customizing Colors

Modify `src/helpers/colors.rs` to change the color scheme:

```rust
impl Colors {
    pub const SURFACE0: u32 = 0xff313244; // Change this for different background
    // ... other colors
}
```

### Testing

```bash
# Check for compilation errors
cargo check

# Run with debug output
RUST_LOG=debug cargo run

# Build optimized release
cargo build --release
```

## Future Enhancements

1. **Event System**: Implement proper event handling for real-time updates
2. **Plugin System**: Dynamic loading of custom items
3. **Configuration File**: TOML/YAML configuration for easier customization
4. **Hot Reloading**: File watching for configuration changes
5. **Performance Monitoring**: Built-in performance metrics
6. **Theme System**: Multiple color schemes
7. **Widget Library**: Pre-built widgets for common use cases

## Troubleshooting

### Common Issues

1. **Build Errors**: Ensure you have Rust nightly installed
2. **Missing Icons**: Install MesloLGL Nerd Font
3. **yabai Integration**: Install yabai for multi-display support
4. **Permission Issues**: Ensure the binary is executable

### Debug Mode

Run with debug logging:
```bash
RUST_LOG=debug ./target/release/sketchybar-config
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

MIT License - see LICENSE file for details.
