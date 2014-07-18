#!/bin/sh

[ -x /usr/sbin/h3clite ] || exit 0

. /lib/functions.sh
. ../netifd-proto.sh
init_proto "$@"

proto_h3c_init_config() {
	proto_config_add_string "username"
	proto_config_add_string "password"
}

proto_h3c_setup() {
	local config="$1"
	local iface="$2"
	json_get_vars username password
	proto_run_command "$config" /usr/sbin/h3clite \
		"$username" "$password" "$iface"
	#TODO: Must be only one proto_run_command
	proto_export "INTERFACE=$config"
	udhcpc \
		-q -i "$iface"
}

proto_h3c_teardown() {
	local interface="$1"
	proto_kill_command "$interface"
}

add_protocol h3c
