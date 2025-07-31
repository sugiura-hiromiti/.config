use crate::helpers::colors::Colors;
use crate::helpers::yabai::DisplayInfo;
use crate::sketchybar::SketchyBar;
use anyhow::Result;

pub async fn setup(bar: &mut SketchyBar, display_info: &DisplayInfo,) -> Result<(),> {
	println!("🕐 Setting up clock item");

	// Add clock item
	bar.add("item", "clock", "right",).await?;

	// Configure clock properties
	bar.set(
		"clock",
		&[
			("update_freq", "1",),
			("width", "dynamic",),
			("position", "right",),
			("label.color", &format!("0x{:08x}", Colors::FLAMINGO),),
			("background.border_color", &format!("0x{:08x}", Colors::FLAMINGO),),
		],
	)
	.await?;

	// Only show on builtin display
	if display_info.is_builtin {
		bar.set("clock", &[("associated_display", &display_info.index.to_string(),),],).await?;
	}

	// Subscribe to events
	bar.subscribe("clock", &["system_woke", "routine",],).await?;

	println!("✅ Clock item configured");
	Ok((),)
}
