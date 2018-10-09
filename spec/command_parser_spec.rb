require_relative "spec_helper"
require_relative "../lib/robot_challenge/commands/move"
require_relative "../lib/robot_challenge/command_parser"

describe CommandParser do
  let(:command_parser) { CommandParser.new(args: args) }

  describe "#parse" do
    context "when the given command is valid" do
      let(:args) { "move" }

      it "returns the matching command object" do
        expect(command_parser).to receive(:valid_command?).and_return(true)

        expect(command_parser.parse).to eq(Command::Move)
      end
    end

    context "when the given command is invalid" do
      let(:args) { "test^&^*" }

      it "returns the unknown command" do
        expect(command_parser).to receive(:valid_command?).and_return(false)

        expect(command_parser.parse).to eq(Command::Unknown)
      end
    end
  end

  describe "#command_args" do
    context "when there are args" do
      let(:args) { "place 1,2,North" }
      let(:expected_output) { ["1","2","North"] }

      it "returns the args without the first item" do
        expect(command_parser.command_args).to eq(expected_output)
      end
    end

    context "when there are no args" do
      let(:args) { "move" }
      let(:expected_output) { [] }

      it "returns the args without the first item" do
        expect(command_parser.command_args).to eq(expected_output)
      end
    end
  end
end
