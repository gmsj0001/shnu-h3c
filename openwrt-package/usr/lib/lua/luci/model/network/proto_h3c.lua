local netmod = luci.model.network
local proto = netmod:register_protocol("h3c")

function proto.get_i18n(self)
	return "H3C 802.1x"
end

