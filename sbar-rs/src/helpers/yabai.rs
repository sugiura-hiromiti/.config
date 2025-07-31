use anyhow::Result;
use serde::Deserialize;
use serde::Serialize;
use std::collections::HashMap;
use std::process::Command;

#[derive(Debug, Clone, Serialize, Deserialize,)]
pub struct DisplayInfo {
	pub index:      u32,
	pub is_builtin: bool,
	pub frame:      DisplayFrame,
}

#[derive(Debug, Clone, Serialize, Deserialize,)]
pub struct DisplayFrame {
	pub x: f64,
	pub y: f64,
	pub w: f64,
	pub h: f64,
}

/// Get all available displays from yabai
pub async fn get_displays() -> Result<HashMap<String, DisplayInfo,>,> {
	let output = Command::new("yabai",).args(["-m", "query", "--displays",],).output()?;

	if !output.status.success() {
		// Fallback if yabai is not available
		println!("⚠️  yabai not available, using default display");
		let mut displays = HashMap::new();
		displays.insert(
			"1".to_string(),
			DisplayInfo {
				index:      1,
				is_builtin: true,
				frame:      DisplayFrame { x: 0.0, y: 0.0, w: 1920.0, h: 1080.0, },
			},
		);
		return Ok(displays,);
	}

	let json_str = String::from_utf8(output.stdout,)?;
	let yabai_displays: Vec<YabaiDisplay,> = serde_json::from_str(&json_str,)?;

	let mut displays = HashMap::new();

	for display in yabai_displays {
		let display_info = DisplayInfo {
			index:      display.index,
			is_builtin: display.label.contains("Built-in",) || display.index == 1,
			frame:      DisplayFrame {
				x: display.frame.x,
				y: display.frame.y,
				w: display.frame.w,
				h: display.frame.h,
			},
		};

		displays.insert(display.index.to_string(), display_info,);
	}

	Ok(displays,)
}

/// Get the builtin display info
pub async fn get_builtin_display() -> Result<Option<DisplayInfo,>,> {
	let displays = get_displays().await?;
	Ok(displays.values().find(|d| d.is_builtin,).cloned(),)
}

/// Get external display indices
pub async fn get_external_displays() -> Result<Vec<DisplayInfo,>,> {
	let displays = get_displays().await?;
	Ok(displays.values().filter(|d| !d.is_builtin,).cloned().collect(),)
}

#[derive(Debug, Deserialize,)]
struct YabaiDisplay {
	index: u32,
	label: String,
	frame: YabaiFrame,
}

#[derive(Debug, Deserialize,)]
struct YabaiFrame {
	x: f64,
	y: f64,
	w: f64,
	h: f64,
}
