require_relative "../spec_helper"
require_relative "../../lib/robot_challenge/commands/move"
require_relative "../../lib/robot_challenge/table"
require_relative "../../lib/robot_challenge/robot"
require_relative "../../lib/robot_challenge/obstacle"

describe Commands::Move do
  let(:orientation) { Position::NORTH }
  let(:position) { Position.new(x: 2, y: 2, orientation: orientation) }
  let(:table) { Table.new }
  let(:robot) { Robot.new(position: position) }
  let(:command) { Commands::Move.new(args: nil, table: table, robot: robot) }

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

        it "moves the robot to the north" do
          expect { command.execute }.to change { robot.position.y }.by(Commands::Move::STEP)
        end
      end

      context "when the current orientation is west" do
        let(:orientation) { Position::WEST }

        it "rotates the robot to the south" do
          expect { command.execute }.to change { robot.position.x }.by(-Commands::Move::STEP)
        end
      end

      context "when the current orientation is south" do
        let(:orientation) { Position::SOUTH }

        it "rotates the robot to the east" do
          expect { command.execute }.to change { robot.position.y }.by(-Commands::Move::STEP)
        end
      end

      context "when the current orientation is east" do
        let(:orientation) { Position::EAST }

        it "rotates the robot to the north" do
          expect { command.execute }.to change { robot.position.x }.by(Commands::Move::STEP)
        end
      end

      context "when there is an obstacle at the next position" do
        let(:obstacle_position) { Position.new(x: 2, y: 3, orientation: Position::NORTH) }

        before do
          table.obstacles.push(Obstacle.new(position: obstacle_position))
        end

        it "does not set the robots position" do
          expect { command.execute }.to_not change { robot.position }
        end
      end
    end
  end
end
