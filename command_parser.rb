require 'httparty'
require 'json'

URL = 'http://10.0.0.150/command'

class Command < Struct.new(:type)
  TYPES = {
    stop: 1,
    forward: 2,
    back: 3,
    left: 4,
    right: 5
  }

  def emit
    `./emit.sh #{TYPES[type.to_sym]}`
  end
end

while true do
  response = HTTParty.get(URL)
  json = JSON.parse(response.body)
  command = Command.new(json['command_type'])
  command.emit
  sleep(1)
end

