require_relative "position"

class Robot
  attr_reader :position

  def initialize(position: nil)
    @position = position
  end

  def valid_position?
    !position.nil?
  end

  def move_to(position)
    @position = position
  end
end
