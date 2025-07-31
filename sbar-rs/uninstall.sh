#!/bin/bash

# SketchyBar Daemon Uninstallation Script

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

# Stop the daemon
stop_daemon() {
    log_info "Stopping SketchyBar daemon..."
    
    if pgrep -f sketchybar-daemon >/dev/null; then
        pkill -f sketchybar-daemon
        log_success "Daemon stopped"
    else
        log_info "Daemon was not running"
    fi
}

# Remove LaunchAgent
remove_launchagent() {
    local plist_file="$HOME/Library/LaunchAgents/com.sketchybar.daemon.plist"
    
    if [[ -f "$plist_file" ]]; then
        log_info "Removing LaunchAgent..."
        
        # Unload the LaunchAgent
        launchctl unload "$plist_file" 2>/dev/null || true
        
        # Remove the plist file
        rm "$plist_file"
        log_success "LaunchAgent removed"
    else
        log_info "No LaunchAgent found"
    fi
}

# Remove binary
remove_binary() {
    local binary_path="/usr/local/bin/sketchybar-daemon"
    
    if [[ -f "$binary_path" ]]; then
        log_info "Removing daemon binary..."
        
        if sudo rm "$binary_path"; then
            log_success "Binary removed"
        else
            log_error "Failed to remove binary"
        fi
    else
        log_info "Binary not found"
    fi
}

# Restore original SketchyBar config
restore_config() {
    local config_file="$HOME/.config/sketchybar/sketchybarrc"
    local backup_pattern="$config_file.backup.*"
    
    if ls $backup_pattern 1> /dev/null 2>&1; then
        local latest_backup=$(ls -t $backup_pattern | head -n1)
        
        local response
        read -p "Restore original SketchyBar config from backup? (y/N): " response
        
        if [[ "$response" =~ ^[Yy]$ ]]; then
            cp "$latest_backup" "$config_file"
            log_success "Original config restored from $latest_backup"
        else
            log_info "Keeping current config"
        fi
    else
        log_warning "No backup config found"
        log_info "You may need to manually configure SketchyBar"
    fi
}

# Clean up logs
cleanup_logs() {
    local log_files=("/tmp/sketchybar-daemon.log" "/tmp/sketchybar-daemon.error.log")
    
    for log_file in "${log_files[@]}"; do
        if [[ -f "$log_file" ]]; then
            rm "$log_file"
            log_success "Removed $log_file"
        fi
    done
}

# Main uninstallation function
main() {
    echo "🗑️  SketchyBar Daemon Uninstallation Script"
    echo "==========================================="
    echo
    
    local response
    read -p "Are you sure you want to uninstall the SketchyBar daemon? (y/N): " response
    
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        log_info "Uninstallation cancelled"
        exit 0
    fi
    
    echo
    stop_daemon
    remove_launchagent
    remove_binary
    restore_config
    cleanup_logs
    
    echo
    log_success "Uninstallation completed successfully! 🎉"
    log_info "You may want to restart SketchyBar: brew services restart sketchybar"
}

# Run main function
main "$@"
