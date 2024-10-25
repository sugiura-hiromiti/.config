use anyhow::Result;
use nvim_oxi::api;
use nvim_oxi::api::opts;
//use nvim_oxi::api::types;
use nvim_oxi::mlua;
use nvim_oxi::mlua::prelude::*;

const ERR_PRE: &str = "🫠nv_config_rs:";

#[nvim_oxi::plugin]
fn nv_config_rs() -> Result<(),> {
	//panic!("this panic is intended");
	plugins()?;
	keymap()?;
	usr_cmd()?;
	auto_cmd()?;
	utils()
}

/// # md
///
/// **a** ~strike~
///
///
///
/// |1|2|3|4|
/// |---:|:---:|:---|---|
/// |~aaa~|*b*|**c**|dish|
///
/// ```rust
/// let a = 3;
/// ```
fn plugins() -> Result<(),> { todo!() }

/// # md
fn keymap() -> Result<(),> {
	api::cmd(
		&api::types::CmdInfos::builder().cmd("smapclear",).build(),
		&api::opts::CmdOpts::default(),
	)?;

	let _opt = opts::SetKeymapOpts::default();
	let set = global::<LuaTable,>("vim",)
		.get::<_, LuaTable>("keymap",)
		.unwrap()
		.get::<_, LuaFunction>("set",)
		.unwrap();

	set.call::<_, ()>((["n", "x",], "<c-a>", set.clone(),),).unwrap();

	Ok((),)
}

/// # doc
/// hey hoo
fn usr_cmd() -> Result<(),> {
	api::create_user_command(
		"RmSwap",
		|_opts| match std::fs::remove_dir_all("~/.local/state/nvim/swap/",) {
			Ok(_,) => println!("🫠 removed swap directory"),
			Err(_,) => eprintln!("🫠 failed to remove swap directory"),
		},
		&opts::CreateCommandOpts::default(),
	)?;

	Ok((),)
}

fn auto_cmd() -> Result<(),> { todo!() }
fn utils() -> Result<(),> { todo!() }

fn get_opt<T: nvim_oxi::conversion::FromObject,>(name: &str,) -> T {
	api::get_option_value::<T,>(name, &opts::OptionOpts::default(),).expect("failed to get {name}",)
}

fn global<'lua, LuaType: mlua::FromLua<'lua,>,>(key: &str,) -> LuaType {
	mlua::lua()
		.globals()
		.get::<&str, LuaType>(key,)
		.expect(&format!("{ERR_PRE}\n\tFrom `crate::lua_globals`\n\tFailed to get `{key}`"),)
}

mod oxi_test {
	use super::*;
	#[nvim_oxi::test]
	fn get_opt_test() {
		assert_eq!(get_opt::<String,>("ft"), "");
		assert_eq!(get_opt::<i32,>("laststatus"), 2);
	}

	#[nvim_oxi::test]
	fn global_test() {
		// get global variable `vim`
		let vim = global::<mlua::prelude::LuaTable,>("vim",);
		let _lua_fn = vim.get::<_, mlua::prelude::LuaTable>("fn",).expect("fn",);

		// this code fails. we can't get nested element at once
		//		let expand =
		//			global::<mlua::prelude::LuaFunction,>("vim['fn']['expand']",);
	}

	#[nvim_oxi::test]
	fn ex_cmd_exec_test() {
		let rslt = api::cmd(
			&api::types::CmdInfos::builder().cmd("smapclear",).build(),
			&api::opts::CmdOpts::default(),
		)
		.unwrap();
		assert_eq!(rslt, None);
	}

	#[nvim_oxi::test]
	fn keymap_test() { let _ = keymap(); }
}
