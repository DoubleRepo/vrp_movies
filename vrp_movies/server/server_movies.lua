Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP", "vrp_cinema_server")

local movies = {
	["PL_CINEMA_CARTOON"] = {
		name = "Cartoon",
		price = 11
	},
	["PL_LES1_FAME_OR_SHAME"] = {
		name = "Fame or Shame",
		price = 10
	},
	["PL_CINEMA_ACTION"] = {
		name = "Action",
		price = 10
	},
	["PL_CINEMA_ARTHOUSE"] = {
		name = "ArtHouse",
		price = 12
	},
	["PL_CINEMA_MULTIPLAYER"] = {
		name = "Meltown",
		price = 10
	},
	["PL_WEB_HOWITZER"] = {
		name = "Howitzer",
		price = 9
	},
	["PL_STD_CNT"] = {
		name = "CNT",
		price = 10
	},
	["PL_WEB_RANGERS"] = {
		name = "Rangers",
		price = 14
	}
}


RegisterServerEvent('vrp_cinema:takemovie')
AddEventHandler('vrp_cinema:takemovie', function (source, derp, price)
	local _source = source
	local player = vRP.getUserId({_source})
	local playerMoney = vRP.getMoney({player})

	if playerMoney >= price then
		vRP.tryPayment({player, price})
			TriggerClientEvent("vrp_cinema:movie", _source, derp)
	else
		vRPclient.notify(_source, {"~r~ Insufficient Money!"})
	end
end)

RegisterServerEvent("vrp_cinema:showmenu")
AddEventHandler("vrp_cinema:showmenu", function ()
	local _source = source
	local player = vRP.getUserId({_source})
	local menudata = {}
	
	menudata.name = "Cinema"
	menudata.css = "align = 'top-left'"

	for k, v in pairs(movies) do
		menudata[v.name] = {function (choice)
			TriggerEvent("vrp_cinema:takemovie", _source, k, v.price)
			vRP.closeMenu({_source})
		end, "$" .. v.price}
	end
	
	vRP.openMenu({_source, menudata})
end)
