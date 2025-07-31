use crate::helpers::colors::Colors;
use crate::helpers::icons::Icons;
use crate::helpers::yabai::DisplayInfo;
use crate::sketchybar::SketchyBar;
use anyhow::Result;

pub async fn setup(bar: &mut SketchyBar, display_info: &DisplayInfo,) -> Result<(),> {
	println!("📱 Setting up current app item");

	// Add current app item
	bar.add("item", "current_app", "left",).await?;

	// Configure current app properties
	bar.set(
		"current_app",
		&[
			("width", "dynamic",),
			("position", "left",),
			("icon", Icons::APP,),
			("icon.color", &format!("0x{:08x}", Colors::MAUVE),),
			("label", "App",),
			("label.color", &format!("0x{:08x}", Colors::MAUVE),),
			("background.border_color", &format!("0x{:08x}", Colors::MAUVE),),
			("associated_display", &display_info.index.to_string(),),
		],
	)
	.await?;

	// Subscribe to app change events
	bar.subscribe("current_app", &["front_app_switched",],).await?;

	println!("✅ Current app item configured");
	Ok((),)
}
