local http_server = require("http.server")
local http_headers = require("http.headers")
local route = {}
route.__index = route

function route.new(header, path, html, css, js, ...)
	local self = setmetatable({
		header = header,
		path = path,
	}, route)
	if html then
		self.html = self.path .. html
	end
	if css then
		self.css = css
	end
	if js then
		self.js = js
	end
	local args = { ... }
	if #args <= 0 then
		return self
	end
	for i, arg in pairs(args) do
		print("route" .. i)
		self["route" .. i] = arg
	end
	return self
end
return route
