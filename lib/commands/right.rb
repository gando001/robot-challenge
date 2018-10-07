require "commands/base"

class Right < Base
	def process
		robot.turn_right
	end

	private

	def valid?
		true
	end
end
