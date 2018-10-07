require "table"
require "position"

class Robot
	attr_reader :table
	attr_accessor :position, :direction

	def initialize(position:, direction:, table:)
		@position = position
		@direction = direction
		@table = table
	end

	def valid_position?
		!position.nil? && table.within_bounds?(position)
	end

	def move
	end

	def turn_left
	end

	def turn_right
	end

	def to_s
		puts "Output: #{position.x}, #{position.y}, #{direction}"
	end
end
