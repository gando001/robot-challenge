require_relative "robot_challenge/user_interface"
require_relative "robot_challenge/table"
require_relative "robot_challenge/robot"
require_relative "robot_challenge/simulator"

user_interface = UserInterface.new
if ARGV.count != 0 && ARGV.count != 2
  user_interface.write_message("Usage: robot_challenge.rb <rows> <columns>")
  return
end

table = Table.new(rows: ARGV[0].to_i, columns: ARGV[1].to_i)
robot = Robot.new

Simulator.new(
  table: table,
  robot: robot,
  user_interface: user_interface
).run
