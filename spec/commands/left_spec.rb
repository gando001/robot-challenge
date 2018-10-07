require "spec_helper"
require "commands/left"
require "table"
require "robot"

describe Left do
	let(:orientation) { Position::NORTH }
	let(:position) { Position.new(x: 0, y: 0, orientation: orientation) }
	let(:table) { Table.new(rows: 5, columns: 5) }
	let(:robot) { Robot.new(position: position) }
	let(:command) { Left.new(args: nil, table: table, robot: robot) }

	describe "#process" do
		context "when the command is invalid" do
			it "does not move the robot" do
    		expect(command).to receive(:valid?).and_return(false)

				expect { command.execute }.to_not change { robot.position }
			end
		end

		context "when the current orientation is north" do
			let(:orientation) { Position::NORTH }

			it "rotates the robot to the west" do
				expect { command.execute }.to change { robot.position }
				expect(robot.position.orientation).to eq(Position::WEST)
			end
		end

		context "when the current orientation is west" do
			let(:orientation) { Position::WEST }

			it "rotates the robot to the south" do
				expect { command.execute }.to change { robot.position }
				expect(robot.position.orientation).to eq(Position::SOUTH)
			end
		end

		context "when the current orientation is south" do
			let(:orientation) { Position::SOUTH }

			it "rotates the robot to the east" do
				expect { command.execute }.to change { robot.position }
				expect(robot.position.orientation).to eq(Position::EAST)
			end
		end

		context "when the current orientation is east" do
			let(:orientation) { Position::EAST }

			it "rotates the robot to the north" do
				expect { command.execute }.to change { robot.position }
				expect(robot.position.orientation).to eq(Position::NORTH)
			end
		end
	end
end
