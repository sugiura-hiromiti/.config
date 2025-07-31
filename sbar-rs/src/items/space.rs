use crate::helpers::colors::Colors;
use crate::helpers::yabai::DisplayInfo;
use crate::sketchybar::SketchyBar;
use anyhow::Result;

pub async fn setup(bar: &mut SketchyBar, display_info: &DisplayInfo,) -> Result<(),> {
	println!("🏠 Setting up space items");

	// Add space items (typically 1-10)
	for i in 1..=10 {
		let space_name = format!("space.{}", i);

		// Add space item
		bar.add("space", &space_name, "left",).await?;

		// Configure space properties
		bar.set(
			&space_name,
			&[
				("icon", &i.to_string(),),
				("icon.color", &format!("0x{:08x}", Colors::TEXT),),
				("background.color", &format!("0x{:08x}", Colors::SURFACE0),),
				("background.border_color", &format!("0x{:08x}", Colors::OVERLAY0),),
				("associated_display", &display_info.index.to_string(),),
			],
		)
		.await?;

		// Subscribe to space events
		bar.subscribe(&space_name, &["space_change", "display_change",],).await?;
	}

	println!("✅ Space items configured");
	Ok((),)
}
