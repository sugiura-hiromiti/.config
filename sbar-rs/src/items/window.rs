use crate::helpers::colors::Colors;
use crate::helpers::icons::Icons;
use crate::helpers::yabai::DisplayInfo;
use crate::sketchybar::SketchyBar;
use anyhow::Result;

pub async fn setup(bar: &mut SketchyBar, display_info: &DisplayInfo,) -> Result<(),> {
	println!("🪟 Setting up window item");

	// Add window item
	bar.add("item", "window", "left",).await?;

	// Configure window properties
	bar.set(
		"window",
		&[
			("width", "dynamic",),
			("position", "left",),
			("icon", Icons::WINDOW,),
			("icon.color", &format!("0x{:08x}", Colors::GREEN),),
			("label", "Window",),
			("label.color", &format!("0x{:08x}", Colors::GREEN),),
			("background.border_color", &format!("0x{:08x}", Colors::GREEN),),
			("associated_display", &display_info.index.to_string(),),
		],
	)
	.await?;

	// Subscribe to window events
	bar.subscribe("window", &["window_focus", "window_title",],).await?;

	println!("✅ Window item configured");
	Ok((),)
}
