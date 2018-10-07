require "spec_helper"
require "commands/left"
require "Robot"

describe Left do
	let(:robot) { instance_double("Robot") }
	let(:command) { Left.new(args: nil, robot: robot) }

	describe "#process" do
		it "instructs the robot to turn left" do
			expect(robot).to receive(:turn_left)

			command.execute
		end
	end
end
