require_relative "../spec_helper"
require_relative "../../lib/robot_challenge/commands/block"
require_relative "../../lib/robot_challenge/table"
require_relative "../../lib/robot_challenge/robot"

describe Commands::Block do
  let(:table) { Table.new }
  let(:position) { Position.new(x: 0, y: 0, orientation: Position::NORTH) }
  let(:robot) { Robot.new(position: position) }
  let(:args) { ["2", "2"] }
  let(:command) { Commands::Block.new(args: args, table: table, robot: robot) }

  describe "#process" do
    context "when the command is invalid" do
      context "when there are no args" do
        let(:args) { [] }

        it "does not add an obstacle to the table" do
          expect { command.execute }.to_not change { table.obstacles }
        end
      end

      context "when there are missing args" do
        let(:args) { ["1"] }

        it "does not add an obstacle to the table" do
          expect { command.execute }.to_not change { table.obstacles }
        end
      end
    end

    context "when the command is valid" do
      before do
        expect(command).to receive(:valid?).at_least(:once).and_return(true)
      end

      context "when there is already an obstacle at the given position" do
        it "does not add an obstacle to the table" do
          expect { command.execute }.to change { table.obstacles.count }.by(1)

          expect { command.execute }.to_not change { table.obstacles }
        end
      end

      context "when the robot is at the given position" do
        before do
          robot.move_to(Position.new(x: 2, y: 2, orientation: Position::NORTH))
        end

        it "does not add an obstacle to the table" do
          expect { command.execute }.to_not change { table.obstacles }
        end
      end

      it "adds an obstacle to the table" do
        expect { command.execute }.to change { table.obstacles.count }.by(1)

        expect(table.obstacles.last.position.x).to eq(2)
        expect(table.obstacles.last.position.y).to eq(2)
        expect(table.obstacles.last.position.orientation).to eq(Position::NORTH)
      end
    end
  end
end