require "commands/base"

class Move < Base
	def process
		robot.move
	end

	private

	def valid?
		robot.valid_position?
	end
end
