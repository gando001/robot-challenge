require_relative "../spec_helper"
require_relative "../../lib/robot_challenge/commands/place"
require_relative "../../lib/robot_challenge/table"
require_relative "../../lib/robot_challenge/robot"
require_relative "../../lib/robot_challenge/obstacle"

describe Commands::Place do
  let(:table) { Table.new }
  let(:robot) { Robot.new }
  let(:args) { ["2", "2", "North"] }
  let(:command) { Commands::Place.new(args: args, table: table, robot: robot) }

  describe "#process" do
    context "when the command is invalid" do
      it "does not change the robots position" do
        expect(command).to receive(:valid?).and_return(false)

        expect { command.execute }.to_not change { robot.position }
      end

      context "when there are no args" do
        let(:args) { [] }

        it "does not change the robots position" do
          expect { command.execute }.to_not change { robot.position }
        end
      end

      context "when there are missing args" do
        let(:args) { ["1","NORTH"] }

        it "does not change the robots position" do
          expect { command.execute }.to_not change { robot.position }
        end
      end
    end

    context "when the command is valid" do
      before do
        expect(command).to receive(:valid?).and_return(true)
      end

      it "sets the robots position" do
        expect { command.execute }.to change { robot.position }

        expect(robot.position.x).to eq(2)
        expect(robot.position.y).to eq(2)
        expect(robot.position.orientation).to eq(Position::NORTH)
      end

      context "when there is an obstacle at the given position" do
        let(:position) { Position.new(x: 2, y: 2, orientation: Position::NORTH) }

        before do
          table.obstacles.push(Obstacle.new(position: position))
        end

        it "does not set the robots position" do
          expect { command.execute }.to_not change { robot.position }
        end
      end
    end
  end
end