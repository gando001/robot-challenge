class Position
  NORTH = 'north'
  EAST = 'east'
  SOUTH = 'south'
  WEST = 'west'
  VALID_ORIENTATIONS = [NORTH, EAST, SOUTH, WEST]

  attr_reader :x, :y, :orientation

  def initialize(x:, y:, orientation:)
    @x = x
    @y = y
    @orientation = orientation
  end

  def to_s
    "Output: #{x},#{y},#{orientation.upcase}"
  end

  def valid_orientation?
    VALID_ORIENTATIONS.include?(orientation)
  end
end
