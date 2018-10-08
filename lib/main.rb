require_relative "table"
require_relative "robot"
require_relative "position"
require_relative "command_parser"
require_relative "user_interface"

class Main
	attr_reader :rows, :columns

	def initialize(rows:, columns:)
		@rows = rows
		@columns = columns
	end

	def run
		loop do
			user_interface.request_command
			requested_command = user_interface.read_command

			next unless valid_request?(requested_command)

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

	def process_request(requested_command)
		parser = CommandParser.new(args: requested_command)
		command_name = parser.parse

		unless command_name.nil?
			command = command_name.new(args: parser.command_args, table: table, robot: robot)
      output = command.execute

      user_interface.write_message(output) if report_command?(command)
    end
  end
end

# Main.new(rows: 5, columns: 5).run
