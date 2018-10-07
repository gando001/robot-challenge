class Position
	NORTH = 'NORTH'
	EAST = 'EAST'
	SOUTH = 'SOUTH'
	WEST = 'WEST'

	attr_reader :x, :y, :orientation

	def initialize(x:, y:, orientation:)
		@x = x
		@y = y
		@orientation = orientation
	end

	def to_s
		"Output: #{x}, #{y}, #{orientation}"
	end
end
