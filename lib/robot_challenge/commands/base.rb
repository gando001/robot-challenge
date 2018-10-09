class Base
  attr_reader :args, :table, :robot

  def initialize(args:, table:, robot:)
    @args = args
    @table = table
    @robot = robot
  end

  def execute
    return unless valid?

    process
  end

  private

  def valid?
    false
  end

  def process
    raise NotImplementedError
  end

  def position_on_table?(position)
    table.within_bounds?(position) && position.valid_orientation?
  end
end
