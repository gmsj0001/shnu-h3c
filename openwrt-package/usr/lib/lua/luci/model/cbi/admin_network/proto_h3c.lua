local map, section, net = ...
local ifc = net:get_interface()

local username, password

username = section:taboption("general", Value, "username", translate("Username"))
password = section:taboption("general", Value, "password", translate("Password"))
password.password = true

luci.tools.proto.opt_macaddr(section, ifc, translate("Override MAC address"))

