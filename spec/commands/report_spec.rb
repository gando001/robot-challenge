require "spec_helper"
require "commands/report"
require "Robot"

describe Report do
	let(:robot) { instance_double("Robot") }
	let(:command) { Report.new(args: nil, robot: robot) }

	describe "#process" do
		it "instructs the robot to output its position" do
			expect(robot).to receive(:to_s)

			command.execute
		end
	end
end
