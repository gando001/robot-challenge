require_relative "command"

class Simulator
  attr_reader :table, :robot, :user_interface

  def initialize(table:, robot:, user_interface:)
    @table = table
    @robot = robot
    @user_interface = user_interface
  end

  def run
    loop do
      requested_command = request_command
      command = Command.new(args: requested_command, table: table, robot: robot)

      break if command.terminating?

      response = command.process

      report_output(response) if command.response_command?
    end
  end

  private

  def request_command
    user_interface.request_command
    user_interface.read_command
  end

  def report_output(output)
    output && user_interface.write_message(output)
  end
end
