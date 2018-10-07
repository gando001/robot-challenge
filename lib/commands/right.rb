require "commands/base"
require "position"

class Right < Base
	def process
		next_position = Position.new(
			x: robot.position.x,
			y: robot.position.y,
			orientation: orientation_on_right(robot.position.orientation)
		)

		robot.move_to(next_position)
	end

	private

	def valid?
		robot.valid_position?
	end

	def orientation_on_right(orientation)
		case orientation
			when Position::NORTH then Position::EAST
			when Position::WEST  then Position::NORTH
			when Position::SOUTH then Position::WEST
			else 			 								Position::SOUTH
		end
	end
end
