require_relative "position"

class Obstacle
  attr_reader :position

  def initialize(position:)
    @position = position
  end

  def located_at?(position)
    @position.located_at?(position)
  end
end
