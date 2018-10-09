require_relative "commands/left"
require_relative "commands/right"
require_relative "commands/move"
require_relative "commands/report"
require_relative "commands/place"
require_relative "commands/unknown"

class CommandParser
  attr_reader :args

  def initialize(args:)
    @args = args.split(' ')
  end

  def parse
    classname = "Command::#{basename.capitalize}"
    classname = "Command::Unknown" unless Object.const_defined?(classname)

    Object.const_get(classname)
  end

  def command_args
    args.drop(1).join.split(',').reject { |arg| arg.length.zero? }
  end

  private

  def basename
    args.first.strip
  end
end
