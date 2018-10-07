require "table"
require "robot"
require "position"
require "input"

class Main
	attr_reader :rows, :columns

	def initialize(rows:, columns:)
		@rows = rows
		@columns = columns
	end

	def run
		user_interface.greeting

		loop do
			user_interface.request_command
			requested_command = user_interface.read_command

			break if input =~ /quit/i

			process_request(requested_command)
    end

	end

	private

	def table
		@table ||= Table.new(rows: rows, columns: columns)
	end

	def robot
		@robot ||= Robot.new(position: nil, direction: nil, table: table)
	end

	def user_interface
		@user_interface ||= UserInterface.new
	end

	def process_request(requested_command)
		parser = CommandParser.new(requested_command)
		command_name = parser.parse

		unless command_name.nil?
			command = command_name.new(args: parser.command_args, robot: robot)
      command.execute
    end
  end
end
