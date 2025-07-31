use anyhow::Result;
use sketchybar_rs::message;
use tokio::time::Duration;
use tokio::time::interval;

/// High-level wrapper around the sketchybar-rs message function
#[derive(Clone,)]
pub struct SketchyBar {
	bar_name: String,
}

impl SketchyBar {
	pub fn new() -> Self {
		Self { bar_name: "sketchybar".to_string(), }
	}

	pub fn set_bar_name(&mut self, name: &str,) {
		self.bar_name = name.to_string();
	}

	pub fn get_bar_name(&self,) -> &str {
		&self.bar_name
	}

	/// Send a raw message to sketchybar
	pub async fn message(&self, msg: &str,) -> Result<String,> {
		let response = message(msg, Some(&self.bar_name,),)
			.map_err(|e| anyhow::anyhow!("SketchyBar error: {}", e),)?;
		Ok(response,)
	}

	/// Send a synchronous message (for use in closures)
	pub fn message_sync(&self, msg: &str,) -> Result<String,> {
		let response = message(msg, Some(&self.bar_name,),)
			.map_err(|e| anyhow::anyhow!("SketchyBar error: {}", e),)?;
		Ok(response,)
	}

	/// Configure bar properties
	pub async fn bar(&mut self, properties: &[(&str, &str,)],) -> Result<(),> {
		let mut cmd = "--bar".to_string();
		for (key, value,) in properties {
			cmd.push_str(&format!(" {}={}", key, value),);
		}
		self.message(&cmd,).await?;
		Ok((),)
	}

	/// Set default properties for items
	pub async fn default(&mut self, properties: &[(&str, &str,)],) -> Result<(),> {
		let mut cmd = "--default".to_string();
		for (key, value,) in properties {
			cmd.push_str(&format!(" {}={}", key, value),);
		}
		self.message(&cmd,).await?;
		Ok((),)
	}

	/// Add an item to the bar
	pub async fn add(&mut self, item_type: &str, name: &str, position: &str,) -> Result<(),> {
		let cmd = format!("--add {} {} {}", item_type, name, position);
		self.message(&cmd,).await?;
		Ok((),)
	}

	/// Set properties for an item
	pub async fn set(&mut self, item_name: &str, properties: &[(&str, &str,)],) -> Result<(),> {
		let mut cmd = format!("--set {}", item_name);
		for (key, value,) in properties {
			cmd.push_str(&format!(" {}={}", key, value),);
		}
		self.message(&cmd,).await?;
		Ok((),)
	}

	/// Subscribe an item to events
	pub async fn subscribe(&mut self, item_name: &str, events: &[&str],) -> Result<(),> {
		let mut cmd = format!("--subscribe {}", item_name);
		for event in events {
			cmd.push_str(&format!(" {}", event),);
		}
		self.message(&cmd,).await?;
		Ok((),)
	}

	/// Enable or disable hotloading
	pub async fn hotload(&mut self, enabled: bool,) -> Result<(),> {
		let cmd = format!("--hotload {}", enabled);
		self.message(&cmd,).await?;
		Ok((),)
	}

	/// Start the event loop with periodic updates
	pub async fn event_loop(&mut self,) -> Result<(),> {
		println!("🔄 Event loop started for bar '{}'", self.bar_name);

		// Clone bar for use in update tasks
		let bar_for_clock = self.clone();
		let bar_for_battery = self.clone();

		// Start clock update task
		let clock_task = tokio::spawn(async move {
			let mut timer = interval(Duration::from_secs(1,),);

			loop {
				timer.tick().await;

				if let Err(e,) = update_clock(&bar_for_clock,) {
					eprintln!("❌ Clock update error: {}", e);
				}
			}
		},);

		// Start battery update task
		let battery_task = tokio::spawn(async move {
			let mut timer = interval(Duration::from_secs(30,),);

			loop {
				timer.tick().await;

				if let Err(e,) = update_battery(&bar_for_battery,) {
					eprintln!("❌ Battery update error: {}", e);
				}
			}
		},);

		// Wait for tasks (they run indefinitely)
		tokio::select! {
			result = clock_task => {
				if let Err(e) = result {
					eprintln!("❌ Clock task error: {}", e);
				}
			}
			result = battery_task => {
				if let Err(e) = result {
					eprintln!("❌ Battery task error: {}", e);
				}
			}
		}

		Ok((),)
	}
}

/// Update clock display
fn update_clock(bar: &SketchyBar,) -> Result<(),> {
	use chrono::Local;

	let now = Local::now();
	let time_str = now.format("%y%m%d %H%M %a",).to_string();

	let cmd = format!("--set clock label={}", time_str);
	bar.message_sync(&cmd,)?;

	Ok((),)
}

/// Update battery display
fn update_battery(bar: &SketchyBar,) -> Result<(),> {
	use crate::helpers::colors;
	use crate::helpers::icons;
	use regex::Regex;
	use std::process::Command;

	// Get battery information using pmset
	let output = Command::new("pmset",).args(["-g", "batt",],).output()?;

	let batt_info = String::from_utf8(output.stdout,)?;

	let mut icon = icons::Icons::ERROR;
	let mut label = "?".to_string();
	let mut color = colors::Colors::YELLOW;

	// Parse battery percentage
	let re = Regex::new(r"(\d+)%",)?;
	if let Some(captures,) = re.captures(&batt_info,) {
		if let Some(charge_match,) = captures.get(1,) {
			let charge: u8 = charge_match.as_str().parse().unwrap_or(0,);
			label = if charge < 10 { format!("0{}", charge) } else { charge.to_string() };

			// Check if charging
			let is_charging = batt_info.contains("AC Power",);

			// Get appropriate icon and color
			icon = icons::battery_icon(charge, is_charging,);
			color = colors::battery_color(charge, is_charging,);
		}
	}

	// Update the battery item
	let cmd = format!(
		"--set battery icon={} icon.color=0x{:08x} icon.padding_left=10 label={} \
		 label.color=0x{:08x} label.padding_right=10",
		icon, color, label, color
	);
	bar.message_sync(&cmd,)?;

	Ok((),)
}
