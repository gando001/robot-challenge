require_relative "../spec_helper"
require_relative "../../lib/robot_challenge/commands/right"
require_relative "../../lib/robot_challenge/robot"

describe Commands::Right do
  let(:orientation) { Position::NORTH }
  let(:position) { Position.new(x: 0, y: 0, orientation: orientation) }
  let(:table) { Table.new }
  let(:robot) { Robot.new(position: position) }
  let(:command) { Commands::Right.new(args: nil, table: table, robot: robot) }

  describe "#process" do
    context "when the command is invalid" do
      it "does not move the robot" do
        expect(command).to receive(:valid?).and_return(false)

        expect { command.execute }.to_not change { robot.position }
      end
    end

    context "when the command is valid" do
      before do
        expect(command).to receive(:valid?).and_return(true)
      end

      context "when the current orientation is north" do
        let(:orientation) { Position::NORTH }

        it "rotates the robot to the east" do
          expect { command.execute }.to change { robot.position }
          expect(robot.position.orientation).to eq(Position::EAST)
        end
      end

      context "when the current orientation is west" do
        let(:orientation) { Position::WEST }

        it "rotates the robot to the north" do
          expect { command.execute }.to change { robot.position }
          expect(robot.position.orientation).to eq(Position::NORTH)
        end
      end

      context "when the current orientation is south" do
        let(:orientation) { Position::SOUTH }

        it "rotates the robot to the west" do
          expect { command.execute }.to change { robot.position }
          expect(robot.position.orientation).to eq(Position::WEST)
        end
      end

      context "when the current orientation is east" do
        let(:orientation) { Position::EAST }

        it "rotates the robot to the south" do
          expect { command.execute }.to change { robot.position }
          expect(robot.position.orientation).to eq(Position::SOUTH)
        end
      end
    end
  end
end
