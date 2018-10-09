require_relative "table"
require_relative "robot"
require_relative "position"
require_relative "command_parser"
require_relative "user_interface"

class Simulator
  attr_reader :rows, :columns

  def initialize(rows:, columns:)
    @rows = rows
    @columns = columns
  end

  def run
    loop do
      requested_command = request_command

      break if terminating?(requested_command)

      process_request(requested_command)
    end
  end

  private

  def table
    @table ||= Table.new(rows: rows, columns: columns)
  end

  def robot
    @robot ||= Robot.new(position: nil)
  end

  def user_interface
    @user_interface ||= UserInterface.new
  end

  def valid_request?(command)
    !command&.strip.length.zero?
  end

  def report_command?(command)
    command.instance_of?(Report)
  end

  def terminating?(command)
    ["q", "quit", "exit"].include?(command.strip.downcase)
  end

  def request_command
    user_interface.request_command
    user_interface.read_command
  end

  def report_output(output)
    user_interface.write_message(output)
  end

  def process_request(requested_command)
    return unless valid_request?(requested_command)

    command = build_command(requested_command)
    execute_command(command)
  end

  def build_command(requested_command)
    parser = CommandParser.new(args: requested_command)
    command_name = parser.parse

    command_name.new(args: parser.command_args, table: table, robot: robot)
  end

  def execute_command(command)
    output = command.execute

    report_output(output) if report_command?(command)
  end
end

# Simulator.new(rows: 5, columns: 5).run
