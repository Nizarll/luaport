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

return utils
