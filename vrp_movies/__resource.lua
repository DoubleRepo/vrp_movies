resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description 'vrp_cinema'

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	'client/client_movies.lua'
}

server_scripts {
	"@vrp/lib/utils.lua",
	'server/server_movies.lua'
}
