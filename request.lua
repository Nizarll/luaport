local request = {}
request.__index = request

local requests = {
  ["GET"]    = true,
  ["POST"]   = true,
  ["HEAD"]   = true,
  ["PUT"]    = true,
  ["DELETE"] = true
}

local function build_header(kind, len, err)
  if err then
    return "HTTP/1.1 404 Not Found\r\n" ..
           "Content-Type: text/" .. kind .. "\r\n"..
           "Content-Length:" .. len .. "\r\n" ..
           "\r\n404 Not Found\r\n"
  end
    return "HTTP/1.1 200 OK\r\n" ..
           "Content-Type: text/" .. kind .. "\r\n" ..
           "Content-Length: " .. len .. "\r\n" ..
           "\r\n"
end

function request.new(header, body, receiver)
  return setmetatable({
    header = header,
    body = body,
    receiver = receiver
  }, request)
end

function request:discard()
  self.receiver:send(build_header('plain', 15))
end

function request:reply_with(kind, reply)
  if not requests[self.header] then return end
  self.receiver:send(build_header(kind, reply:len()) .. reply)
  self.receiver:close()
end

return request
