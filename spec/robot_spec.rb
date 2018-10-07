require "spec_helper"
require "robot"

describe Robot do
	let(:position) { Position.new(x: 0, y: 0, orientation: Position::NORTH) }
	let(:robot) { Robot.new(position: position) }

	describe "#valid_position?" do
		context "when the robot has a position" do
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
	end

	describe "#move_to" do
		let(:current_position) { robot.position }
		let(:new_position) { Position.new(x: 0, y: 0, orientation: Position::NORTH) }

		it "alters the robots position" do
			expect { robot.move_to(new_position) }.to change { robot.position }.from(current_position).to(new_position)
		end
	end
end
