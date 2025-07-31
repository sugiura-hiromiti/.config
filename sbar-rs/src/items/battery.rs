use crate::helpers::yabai::DisplayInfo;
use crate::sketchybar::SketchyBar;
use anyhow::Result;

pub async fn setup(bar: &mut SketchyBar, display_info: &DisplayInfo,) -> Result<(),> {
	println!("🔋 Setting up battery item");

	// Add battery item
	bar.add("item", "battery", "right",).await?;

	// Configure battery properties
	bar.set(
		"battery",
		&[
			("width", "dynamic",),
			("position", "right",),
			("associated_display", &display_info.index.to_string(),),
		],
	)
	.await?;

	// Subscribe to events
	bar.subscribe("battery", &["routine", "power_source_change", "system_woke",],).await?;

	println!("✅ Battery item configured");
	Ok((),)
}
