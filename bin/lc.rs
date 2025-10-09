#!/usr/bin/env -S cargo --quiet -Zscript run --release --manifest-path
---
[package]
version="0.0.1"
edition="2024"

[dependencies]
strum = "0.25"
strum_macros = "0.25"
---

use std::str::FromStr;
use strum::EnumProperty;

const PATH: &str = "Library/LaunchAgents";

fn main() {
	let service =
		Service::from_str(&std::env::args().nth(1,).unwrap(),).unwrap();
	let action = Action::from_str(&std::env::args().nth(2,).unwrap(),).unwrap();

	match action {
		Action::Restart => {
			run(&service, &Action::Stop,);
			run(&service, &Action::Start,);
		},
		_ => run(&service, &action,),
	}
}

fn run(service: &Service, action: &Action,) {
	println!("{action} service {service}");

	let name = service.get_str("FullName",).unwrap().split(' ',);
	let home = std::env::var("HOME",).unwrap();
	let service_path = name.map(|name| format!("{home}/{PATH}/{name}"),);

	std::process::Command::new("launchctl",)
		.arg(action.get_str("FullName",).unwrap(),)
		.args(service_path,)
		.output()
		.expect("failed to execute process",);
}

#[derive(
	Clone,
	Debug,
	strum_macros::Display,
	strum_macros::EnumString,
	strum_macros::EnumProperty,
)]
#[strum(serialize_all = "snake_case")]
enum Service {
	// #[strum(props(FullName = "com.sugiura-hiromiti.sketchybar_builtin.\
	//                           plist com.sugiura-hiromiti.\
	//                           sketchybar_external_1.plist"))]
	#[strum(props(FullName = "com.sugiura-hiromiti.sketchybar_builtin.plist"))]
	Sketchybar,
}

#[derive(
	Clone,
	Debug,
	strum_macros::Display,
	strum_macros::EnumString,
	strum_macros::EnumProperty,
)]
#[strum(serialize_all = "snake_case")]
enum Action {
	#[strum(props(FullName = "load"))]
	Start,
	#[strum(props(FullName = "unload"))]
	Stop,
	Restart,
}
