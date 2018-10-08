require_relative "commands/left"
require_relative "commands/right"
require_relative "commands/move"
require_relative "commands/report"
require_relative "commands/place"

class CommandParser
	attr_reader :args

	def initialize(args:)
		@args = args.split(' ')
	end

	def parse
		classname = "#{basename.capitalize}"
    return unless Object.const_defined?(classname)

    Object.const_get(classname)
	end

	def command_args
		args.drop(1).join.split(',')
	end

	private

	def basename
		args.first.strip
	end
end