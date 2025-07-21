#!/usr/bin/env -S cargo +nightly -q -Zscript run --release --manifest-path
---
[package]
version="0.0.1"
edition="2024"

[dependencies]
anyhow = "*"
---

use anyhow::Result as Rslt;
use std::env;

const SBARLUA_DYLIB_PATH: &str = env!("SBARLUA_DYLIB_PATH");
const PATH: &str = env!("PATH");
const HOME: &str = env!("HOME");

fn main() -> Rslt<(),> {
	let labels = ["builtin", "external_1",];
	labels.iter().for_each(|s| {
            let executable_path = if *s == "builtin" { format!("{HOME}/.nix-profile/bin/sketchybar") } else { format!("{HOME}/.local/bin/{s}") };
            let config_path = format!("{HOME}/.config/sbar/{s}");
            let label = format!("com.sugiura-hiromiti.sketchybar_{s}");
            let (stdout_log, stderr_log)={
                let path = format!("{HOME}/.local/state/sketchybar/sbar_{s}");
                (format!("{path}_out.log"), format!("{path}_err.log"))
            };
	    let content = format!(
		r#"<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>EnvironmentVariables</key>
        <dict>
                <key>LANG</key>
                <string>en_US.UTF-8</string>
                <key>SBARLUA_DYLIB_PATH</key>
                <string>{SBARLUA_DYLIB_PATH}</string>
                <key>PATH</key>
                <string>{PATH}</string>
        </dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>{label}</string>
        <key>LimitLoadToSessionType</key>
        <array>
                <string>Aqua</string>
                <string>Background</string>
                <string>LoginWindow</string>
                <string>StandardIO</string>
                <string>System</string>
        </array>
        <key>ProcessType</key>
        <string>Interactive</string>
        <key>ProgramArguments</key>
        <array>
		  <string>{executable_path}</string>
                <string>-c</string>
                <string>{config_path}</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>StandardErrorPath</key>
        <string>{stderr_log}</string>
        <key>StandardOutPath</key>
        <string>{stdout_log}</string>
</dict>
</plist>
"#
            );

            let plist_path = format!("{HOME}/Library/LaunchAgents/{label}.plist");
            std::fs::write(plist_path, content).expect("failed to write")
        });

	Ok((),)
}
