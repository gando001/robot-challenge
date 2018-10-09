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
    return Command::Unknown unless valid_command?

    Object.const_get(command_class)
  end

  def command_args
    @command_args ||= args.drop(1).join.split(',').reject { |arg| arg.length.zero? }
  end

  private

  def valid_command?
    supplied_command_name? && Object.const_defined?(command_class)
  end

  def supplied_command_name?
    !command_name.length.zero?
  end

  def command_name
    @command_name ||= args.first.gsub("^", "").gsub(/[^A-z]/, "").strip
  end

  def command_class
    @command_class ||= "Command::#{command_name.capitalize}"
  end
end
