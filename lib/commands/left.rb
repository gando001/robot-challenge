require "commands/base"

class Left < Base
	def process
		robot.turn_left
	end

	private

	def valid?
		true
	end
end
