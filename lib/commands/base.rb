class Base
	attr_reader :args, :robot

	def initialize(args:, robot:)
		@args = args
		@robot = robot
	end

	def execute
		return unless valid?

		process
	end

	private

	def valid?
		false
	end

	def process
		raise NotImplementedError
	end
end
