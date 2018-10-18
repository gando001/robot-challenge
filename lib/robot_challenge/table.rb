require_relative "position"

class Table
  attr_reader :rows, :columns

  def initialize(rows: 5, columns: 5)
    @rows = 0...rows
    @columns = 0...columns
  end

  def within_bounds?(position)
    @rows.cover?(position.x) && @columns.cover?(position.y)
  end
end
