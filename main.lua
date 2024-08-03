local server = require("server")
local router = require("router")
local utils = require("utils")

local routes = "routes/"
local webserver = server.new("localhost", 8080)

routes = {
	root = router.new(
		"/",
		routes .. "root/",
		"main.html",
		router.new("/css/styles.css", "routes/css/styles.css"),
		router.new("/main.js", "routes/root/main.js"),
		router.new("/profile.png", "routes/root/profile.png")
	),
}

function get_path(header)
	for key, route in pairs(routes) do
		if utils.ends_with(header, "css") and header == route.css.header then
			return route.css.path
		elseif utils.ends_with(header, "js") and header == route.js.header then
			return route.js.path
		elseif utils.ends_with(header, "png") and header == route.route1.header then
			print(route.route1.header .. " " .. route.route1.path)
			return route.route1.path
		elseif route.header == header then
			return route.html
		end
	end
end

while 1 do
	local request = webserver:await_request()
	if not request then
		goto continue
	end
	if request.body == "favicon.ico" then
		request:discard()
	end
	print("client request : " .. request.header .. " : " .. request.body)
	local content = utils.read(get_path(request.body) or "routes/root/main.html")
	if utils.ends_with(request.body, "css") then
		request:reply_with("css", content)
	elseif utils.ends_with(request.body, "js") then
		request:reply_with("js", content)
	else
		request:reply_with("html", content)
	end
	::continue::
end
