local socket = require 'socket'
local request = require 'request'

local server = {}
server.__index = server

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function server.new(ip, port)
  local self = setmetatable({
    ip = ip or "localhost",
    port = port or 8080,
  }, server)
  self.handler = assert(socket.bind(self.ip, self.port))
  print('created server with: ' .. self.ip .. ':' .. tostring(self.port) .. '\n')
  return self
end

function server:receive()
  local client = self.handler:accept()
  client:settimeout(10)
  local request, err = client:receive()
  return request, client, err
end

function server:await_request()
  local req, client, err = self:receive()
  if err then return end
  local items = split(req)
  return request.new(items[1], items[2], client)
end

return server
