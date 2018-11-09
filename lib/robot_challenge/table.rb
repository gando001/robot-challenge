require_relative "position"

class Table
  attr_reader :rows, :columns, :obstacles

  def initialize(rows: 5, columns: 5)
    @rows = 0...rows
    @columns = 0...columns
    @obstacles = []
  end

  def within_bounds?(position)
    @rows.cover?(position.x) && @columns.cover?(position.y)
  end

  def obstacle_at?(position)
    obstacles.any? { |obstacle| obstacle.located_at?(position) }
  end
end
