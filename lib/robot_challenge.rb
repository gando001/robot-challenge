require_relative "robot_challenge/simulator"

table = Table.new
robot = Robot.new
user_interface = UserInterface.new

Simulator.new(
  table: table,
  robot: robot,
  user_interface: user_interface
).run
