require "spec_helper"
require "commands/right"
require "Robot"

describe Right do
	let(:robot) { instance_double("Robot") }
	let(:command) { Right.new(args: nil, robot: robot) }

	describe "#process" do
		it "instructs the robot to turn right" do
			expect(robot).to receive(:turn_right)

			command.execute
		end
	end
end
