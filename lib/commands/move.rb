require "commands/base"

class Move < Base
	STEP = 1

	def process
		robot.move_to(next_position)
	end

	private

	def valid?
		robot.valid_position? && position_on_table?(next_position)
	end

	def next_position
		@next_position ||= begin
			position = robot.position

			case position.orientation
				when Position::NORTH
					Position.new(x: position.x + STEP, y: position.y, orientation: position.orientation)
				when Position::WEST
					Position.new(x: position.x, y: position.y - STEP, orientation: position.orientation)
				when Position::SOUTH
					Position.new(x: position.x - STEP, y: position.y, orientation: position.orientation)
				else
					Position.new(x: position.x, y: position.y + STEP, orientation: position.orientation)
			end
		end
	end
end
