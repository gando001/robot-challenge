require "commands/left"
require "commands/right"
require "commands/move"
require "commands/report"
# require "commands/place"

class CommandParser
	attr_reader :args

	def initialize(args:)
		@args = args.split(',')
	end

	def parse
		classname = "#{basename.capitalize}"
    return unless Object.const_defined?(classname)

    Object.const_get(classname)
	end

	def command_args
		args.drop(1)
	end

	private

	def basename
		args.first
	end
end
