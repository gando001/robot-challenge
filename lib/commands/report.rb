require "commands/base"

class Report < Base
	def process
		robot.to_s
	end

	private

	def valid?
		true
	end
end
