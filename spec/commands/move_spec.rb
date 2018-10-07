require "spec_helper"
require "commands/move"
require "Robot"

describe Move do
	let(:robot) { instance_double("Robot") }
	let(:command) { Move.new(args: nil, robot: robot) }

	describe "#process" do
		context "when the command is invalid" do
			it "does not instruct the robot to move" do
    		expect(command).to receive(:valid?).and_return(false)

				expect(robot).not_to receive(:move)

				command.execute
			end
		end

		context "when the command is valid" do
			it "instructs the robot to move" do
    		expect(command).to receive(:valid?).and_return(true)

				expect(robot).to receive(:move)

				command.execute
			end
		end
	end
end
