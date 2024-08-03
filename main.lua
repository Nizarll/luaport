local server = require 'server'
local router = require 'router'
local utils = require 'utils'

local base_path = 'pages/'
local webserver = server.new('localhost', 8080)

routes = {
  root = router.new('/', base_path, 'main.html', 'styles.css'),
}

while 1 do
  local request = webserver:await_request()
  if request.body == 'favicon.ico' then
    request:discard()
  end
  local content = utils.read(utils.get_path(request.body) or base_path .. 'html/main.html')
  if utils.ends_with(request.body, 'css') then
    request:reply_with('css', content)
  elseif utils.ends_with(request.body, 'js') then
    request:reply_with('js', content)
  else
    request:reply_with('html', content)
  end
end
