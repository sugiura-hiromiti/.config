use crate::helpers::colors::Colors;
use crate::helpers::icons::Icons;
use crate::helpers::yabai::DisplayInfo;
use crate::sketchybar::SketchyBar;
use anyhow::Result;

pub async fn setup(bar: &mut SketchyBar, display_info: &DisplayInfo,) -> Result<(),> {
	println!("⌨️  Setting up keyboard item");

	// Add keyboard item
	bar.add("item", "keyboard", "right",).await?;

	// Configure keyboard properties
	bar.set(
		"keyboard",
		&[
			("width", "dynamic",),
			("position", "right",),
			("icon", Icons::KEYBOARD,),
			("icon.color", &format!("0x{:08x}", Colors::BLUE),),
			("label", "US",),
			("label.color", &format!("0x{:08x}", Colors::BLUE),),
			("background.border_color", &format!("0x{:08x}", Colors::BLUE),),
		],
	)
	.await?;

	// Only show on builtin display
	if display_info.is_builtin {
		bar.set("keyboard", &[("associated_display", &display_info.index.to_string(),),],).await?;
	}

	println!("✅ Keyboard item configured");
	Ok((),)
}
