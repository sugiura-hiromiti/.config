#!/bin/bash

# SketchyBar Daemon Installation Script
# This script installs and configures the SketchyBar Rust daemon

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check for Rust
    if ! command_exists cargo; then
        log_error "Rust is not installed. Please install Rust first:"
        echo "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
        exit 1
    fi
    log_success "Rust is installed"
    
    # Check for SketchyBar
    if ! command_exists sketchybar; then
        log_error "SketchyBar is not installed. Please install it first:"
        echo "brew install sketchybar"
        exit 1
    fi
    log_success "SketchyBar is installed"
    
    # Check for yabai (optional)
    if command_exists yabai; then
        log_success "yabai is installed (multi-display support enabled)"
    else
        log_warning "yabai is not installed (multi-display support disabled)"
    fi
}

# Build the project
build_project() {
    log_info "Building SketchyBar daemon..."
    
    if ! cargo build --release; then
        log_error "Failed to build the project"
        exit 1
    fi
    
    log_success "Build completed successfully"
}

# Install the binary
install_binary() {
    log_info "Installing daemon binary..."
    
    local binary_path="target/release/sketchybar-daemon"
    local install_path="/usr/local/bin/sketchybar-daemon"
    
    if [[ ! -f "$binary_path" ]]; then
        log_error "Binary not found at $binary_path"
        exit 1
    fi
    
    # Copy binary to system location
    if sudo cp "$binary_path" "$install_path"; then
        sudo chmod +x "$install_path"
        log_success "Binary installed to $install_path"
    else
        log_error "Failed to install binary"
        exit 1
    fi
}

# Setup SketchyBar configuration
setup_sketchybar_config() {
    log_info "Setting up SketchyBar configuration..."
    
    local config_dir="$HOME/.config/sketchybar"
    local config_file="$config_dir/sketchybarrc"
    
    # Create config directory
    mkdir -p "$config_dir"
    
    # Backup existing config if it exists
    if [[ -f "$config_file" ]]; then
        local backup_file="$config_file.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$config_file" "$backup_file"
        log_warning "Existing config backed up to $backup_file"
    fi
    
    # Create new config
    cat > "$config_file" << 'EOF'
#!/bin/bash

# SketchyBar Rust Daemon Configuration
# This configuration launches the Rust daemon instead of shell scripts

# Kill any existing daemon instances
pkill -f sketchybar-daemon 2>/dev/null || true

# Start the Rust daemon
exec /usr/local/bin/sketchybar-daemon
EOF
    
    chmod +x "$config_file"
    log_success "SketchyBar configuration created"
}

# Setup LaunchAgent (optional)
setup_launchagent() {
    local response
    echo
    read -p "Do you want to set up a LaunchAgent for automatic startup? (y/N): " response
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        log_info "Setting up LaunchAgent..."
        
        local plist_dir="$HOME/Library/LaunchAgents"
        local plist_file="$plist_dir/com.sketchybar.daemon.plist"
        
        mkdir -p "$plist_dir"
        
        cat > "$plist_file" << 'EOF'
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
        
        # Load the LaunchAgent
        if launchctl load "$plist_file"; then
            log_success "LaunchAgent created and loaded"
        else
            log_warning "LaunchAgent created but failed to load"
        fi
    else
        log_info "Skipping LaunchAgent setup"
    fi
}

# Restart SketchyBar
restart_sketchybar() {
    log_info "Restarting SketchyBar..."
    
    if brew services restart sketchybar; then
        log_success "SketchyBar restarted successfully"
    else
        log_warning "Failed to restart SketchyBar via brew services"
        log_info "You may need to restart manually"
    fi
}

# Verify installation
verify_installation() {
    log_info "Verifying installation..."
    
    # Check if daemon is running
    sleep 2
    if pgrep -f sketchybar-daemon >/dev/null; then
        log_success "SketchyBar daemon is running"
    else
        log_warning "SketchyBar daemon is not running"
        log_info "Check logs with: tail -f /tmp/sketchybar-daemon.log"
    fi
    
    # Check if binary exists
    if [[ -x "/usr/local/bin/sketchybar-daemon" ]]; then
        log_success "Daemon binary is installed and executable"
    else
        log_error "Daemon binary is not properly installed"
    fi
}

# Print usage information
print_usage() {
    echo
    log_info "Installation complete! Here are some useful commands:"
    echo
    echo "  Start daemon:     sketchybar-daemon"
    echo "  Debug mode:       RUST_LOG=debug sketchybar-daemon"
    echo "  Check status:     pgrep -f sketchybar-daemon"
    echo "  View logs:        tail -f /tmp/sketchybar-daemon.log"
    echo "  Stop daemon:      pkill -f sketchybar-daemon"
    echo
    log_info "For more information, see the README.md file"
}

# Main installation function
main() {
    echo "🦀 SketchyBar Daemon Installation Script"
    echo "========================================"
    echo
    
    check_prerequisites
    build_project
    install_binary
    setup_sketchybar_config
    setup_launchagent
    restart_sketchybar
    verify_installation
    print_usage
    
    echo
    log_success "Installation completed successfully! 🎉"
}

# Run main function
main "$@"
