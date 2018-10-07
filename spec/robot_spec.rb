require "spec_helper"
require "robot"

describe Robot do
	let(:table) { Table.new(rows: 5, columns: 5) }
	let(:robot) { Robot.new(position: position, direction: nil, table: table) }

	describe "#valid_position?" do
		let(:position) { Position.new(0, 0) }

		context "when the robot has a valid position" do
			it "returns true" do
				expect(robot.valid_position?).to be true
			end
		end

		context "when the robot has no position" do
			let(:position) { nil }

			it "returns false" do
				expect(robot.valid_position?).to be false
			end
		end

		context "when the robots position is out of bounds" do
			let(:position) { Position.new(-1, 0) }

			it "returns false" do
				expect(robot.valid_position?).to be false
			end
		end
	end
end
