local utils = {}

function utils.read(path)
  local f = assert(io.open(path, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

function utils.ends_with(str, ext)
  return str:sub(-ext:len()) == ext
end

function utils.get_path(header)
  for key, route in pairs(routes) do
    if utils.ends_with(header, 'css') then return route.css
    elseif utils.ends_with(header, 'js') then return route.js
    elseif route.header == header then return route.html end
  end
end

return utils
