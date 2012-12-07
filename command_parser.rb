require 'httparty'
require 'json'

URL = 'http://10.0.0.150/command'

class Command
  TYPES = {
    stop: 1,
    forward: 2,
    back: 3,
    left: 4,
    right: 5
  }
  attr_reader :type, :power

  def initialize(type, power)
    @type = type
    @power = power.to_i || 0
  end

  def emit
    puts "command: #{type}, power: #{power}, code: #{code}"
    # `./emit.sh #{code}`
  end

  def code
    TYPES[type.to_sym] * 10 + power
  end
end

while true do
  response = HTTParty.get(URL)
  json = JSON.parse(response.body)
  command = Command.new(json['command_type'], json['power'])
  command.emit
  sleep(1)
end

