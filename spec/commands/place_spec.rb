require "spec_helper"
require "commands/place"
require "table"
require "robot"

describe Place do
  let(:table) { Table.new(rows: 5, columns: 5) }
  let(:robot) { Robot.new(position: nil) }
  let(:args) { ["2", "2", "North"] }
  let(:command) { Place.new(args: args, table: table, robot: robot) }

  describe "#process" do
    context "when the command is invalid" do
      it "does not change the robots position" do
        expect(command).to receive(:valid?).and_return(false)

        expect { command.execute }.to_not change { robot.position }
      end
    end

    context "when there are no args" do
      let(:args) { [] }

      it "does not change the robots position" do
        expect { command.execute }.to_not change { robot.position }
      end
    end

    context "when the command is valid" do
      it "sets the robots position" do
        expect { command.execute }.to change { robot.position }

        expect(robot.position.x).to eq(2)
        expect(robot.position.y).to eq(2)
        expect(robot.position.orientation).to eq(Position::NORTH)
      end
    end
  end
end