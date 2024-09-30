use anyhow::anyhow;
use anyhow::Result;
use nvim_oxi::api;
use nvim_oxi::api::opts::CreateCommandOpts;
use nvim_oxi::api::opts::OptionOpts;

#[nvim_oxi::plugin]
fn nv_config_rs() -> Result<(),> {
	//panic!("this panic is intended");
	plugins()?;
	keymap()?;
	usr_cmd()?;
	auto_cmd()?;
	utils()
}

fn plugins() -> Result<(),> { todo!() }
fn keymap() -> Result<(),> { todo!() }
fn usr_cmd() -> Result<(),> {
	api::create_user_command(
		"Make",
		|args| {
			let ft = get_opt::<String,>("ft",);
			assert_ne!(ft, "");
		},
		&CreateCommandOpts::default(),
	)?;
	todo!()
}
fn auto_cmd() -> Result<(),> { todo!() }
fn utils() -> Result<(),> { todo!() }

fn get_opt<T: nvim_oxi::conversion::FromObject,>(name: &str,) -> T {
	api::get_option_value::<T,>(name, &OptionOpts::default(),)
		.expect("failed to get {name}",)
}

mod oxi_test {
	use super::*;
	#[nvim_oxi::test]
	fn get_opt_test() {
		assert_eq!(get_opt::<String,>("ft"), "");
		assert_eq!(get_opt::<i32,>("laststatus"), 2);
	}
}
