require_relative "commands/report"
require_relative "commands/unknown"

class Command
  attr_reader :args, :table, :robot

  def initialize(args:, table:, robot:)
    @args = args.split(' ')
    @table = table
    @robot = robot
  end

  def terminating?
    supplied_command_name? && termination_commands.include?(command_name)
  end

  def process
    command_type.new(args: command_args, table: table, robot: robot).execute
  end

  def response_command?
    command_type == Commands::Report || command_type == Commands::Unknown
  end

  private

  def command_type
    @command_type ||= valid? ? Object.const_get(command_class) : Commands::Unknown
  end

  def supplied_command_name?
    !args.length.zero? && !command_name.length.zero?
  end

  def valid?
    supplied_command_name? && Object.const_defined?(command_class)
  end

  def command_name
    @command_name ||= args.first.gsub("^", "").gsub(/[^A-z]/, "").strip.downcase
  end

  def command_class
    @command_class ||= "Commands::#{command_name.capitalize}"
  end

  def termination_commands
    ["q", "quit", "exit"]
  end

  def command_args
    @command_args ||= args.drop(1).join.split(',').reject { |arg| arg.length.zero? }
  end
end
