require "spec_helper"
require "commands/report"
require "robot"

describe Report do
	let(:position) { Position.new(x: 2, y: 2, orientation: Position::NORTH) }
	let(:robot) { Robot.new(position: position) }
	let(:command) { Report.new(args: nil, table: nil, robot: robot) }

	describe "#process" do
		it "returns the robots position" do
			expect(command.execute).to eq("Output: 2, 2, NORTH")
		end
	end
end
