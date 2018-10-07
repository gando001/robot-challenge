require "position"

class Robot
	attr_reader :position

	def initialize(position:)
		@position = position
	end

	def valid_position?
		!position.nil?
	end

	def move_to(position)
		@position = position
	end
end
