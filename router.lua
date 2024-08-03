local http_server = require  'http.server'
local http_headers = require 'http.headers'
local route = {}
route.__index = route

function route.new(header, path, html, css, js)
  local self = setmetatable({
    header = header,
    path = path,
  }, route)
  if html then
    self.html = self.path .. 'html/' ..html
  end
  if css then
    self.css = self.path .. 'css/' ..css
  end
  if js then
    self.js = self.path .. 'js/' ..js
  end
  return self
end
return route
