require_relative "../spec_helper"
require_relative "../../lib/robot_challenge/commands/place"
require_relative "../../lib/robot_challenge/table"
require_relative "../../lib/robot_challenge/robot"

describe Command::Place do
  let(:table) { Table.new }
  let(:robot) { Robot.new(position: nil) }
  let(:args) { ["2", "2", "North"] }
  let(:command) { Command::Place.new(args: args, table: table, robot: robot) }

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
    end
  end
end