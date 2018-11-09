require_relative "spec_helper"
require_relative "../lib/robot_challenge/commands/move"
require_relative "../lib/robot_challenge/table"
require_relative "../lib/robot_challenge/robot"
require_relative "../lib/robot_challenge/command"

describe Command do
  let(:table) { Table.new }
  let(:robot) { Robot.new }
  let(:command) { Command.new(args: args, table: table, robot: robot) }

  describe "#terminating?" do
    subject(:terminating) { command.terminating? }

    context "when no command is supplied" do
      let(:args) { "" }

      it "returns false" do
        expect(terminating).to be false
      end
    end

    context "when the command is empty" do
      let(:args) { " " }

      it "returns false" do
        expect(terminating).to be false
      end
    end

    context "when given a non-termination command" do
      let(:args) { "test" }

      it "returns false" do
        expect(terminating).to be false
      end
    end

    context "when given a termination command" do
      let(:args) { "test" }

      it "returns true" do
        expect(command).to receive(:termination_commands).and_return([args])

        expect(terminating).to be true
      end
    end
  end

  describe "#process" do
    subject(:process) { command.process }

    context "when no command is supplied" do
      let(:args) { "" }

      it "returns the unknown command message" do
        expect(process).to eq("Unknown command!")
      end
    end

    context "when the command is empty" do
      let(:args) { " " }

      it "returns the unknown command message" do
        expect(process).to eq("Unknown command!")
      end
    end

    context "when the given command is invalid" do
      let(:args) { "test^&^*" }

      it "returns the unknown command message" do
        expect(process).to eq("Unknown command!")
      end
    end

    context "when the given the move command" do
      let(:args) { "move" }

      it "returns nil" do
        expect(process).to be nil
      end
    end

    context "when the given the left command" do
      let(:args) { "left" }

      it "returns nil" do
        expect(process).to be nil
      end
    end

    context "when the given the right command" do
      let(:args) { "right" }

      it "returns nil" do
        expect(process).to be nil
      end
    end

    context "when the given the place command" do
      let(:args) { "place 1,1,north" }

      it "returns the position" do
        expect(process).to_not be nil
      end
    end

    context "when the given the report command" do
      let(:args) { "report" }
      let(:position) { Position.new(x: 1, y: 1, orientation: Position::NORTH) }

      before { robot.move_to(position) }

      it "returns the robots position" do
        expect(process).to eq("Output: 1,1,NORTH")
      end
    end

    context "when the given the block command" do
      let(:position) { Position.new(x: 1, y: 1, orientation: Position::NORTH) }

      context "when the robot is located at the obstacles position" do
        let(:args) { "block 1,1" }
        let(:robot) { Robot.new(position: position) }

        it "returns nil" do
          expect(process).to be nil
        end
      end

      context "when there is an obstacle located at the given position" do
        let(:args) { "block 1,1" }

        before { table.obstacles.push(Obstacle.new(position: position)) }

        it "returns nil" do
          expect(process).to be nil
        end
      end

      context "when successfully adding an obstacle at the given position" do
        let(:args) { "block 1,1" }

        it "returns non-nil" do
          expect(process).to_not be nil
        end
      end
    end
  end

  describe "#response_command?" do
    subject(:response_command) { command.response_command? }

    context "when the report command is supplied" do
      let(:args) { "report" }

      it "returns true" do
        expect(response_command).to be true
      end
    end

    context "when an unknown command is supplied" do
      let(:args) { "test" }

      it "returns true" do
        expect(response_command).to be true
      end
    end

    context "when the move command is supplied" do
      let(:args) { "move" }

      it "returns false" do
        expect(response_command).to be false
      end
    end
  end
end
