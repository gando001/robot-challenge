require_relative "spec_helper"
require_relative "../lib/robot_challenge/simulator"

describe Simulator do
  let(:simulator) { Simulator.new(rows: 5, columns: 5) }
  let(:quit_command) { "QUIT" }

  def quit_simulator
    expect(simulator).to receive(:request_command).and_return(quit_command)
  end

  describe "#run" do
    def execute_test
      quit_simulator
      simulator.run
    end

    it "stops when issued terminating command" do
      expect(simulator).to receive(:request_command).once.and_return(quit_command)

      expect(simulator).to_not receive(:process_request).with(quit_command)

      simulator.run
    end

    context "when the command is empty" do
      it "continues to ask for commands until a command is given" do
        5.times do |_|
          expect(simulator).to receive(:request_command).and_return("")
        end

        execute_test
      end
    end

    context "when the command is known" do
      let(:command) { "move" }

      it "processes the command" do
        expect(simulator).to receive(:request_command).and_return(command)
        expect(simulator).to receive(:process_request).once.with(command)

        execute_test
      end
    end
  end

  describe "integration tests" do
    def apply_commands
      commands.each do |command|
        expect(simulator).to receive(:request_command).and_return(command)
      end
    end

    def check_output
      expect(simulator).to receive(:report_output).with(expected_output)
    end

    def execute_test
      apply_commands
      check_output

      quit_simulator
      simulator.run
    end

    context "simple commands; example 1" do
      let(:commands) { ["PLACE 0,0,NORTH", "MOVE", "REPORT"] }
      let(:expected_output) { "Output: 0,1,NORTH" }

      it "reports 0,1,NORTH" do
        execute_test
      end
    end

    context "simple commands; example 2" do
      let(:commands) { ["PLACE 0,0,NORTH", "LEFT", "REPORT"] }
      let(:expected_output) { "Output: 0,0,WEST" }

      it "reports 0,0,WEST" do
        execute_test
      end
    end

    context "simple commands; example 3" do
      let(:commands) { ["PLACE 1,2,EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT"] }
      let(:expected_output) { "Output: 3,3,NORTH" }

      it "reports 3,3,NORTH" do
        execute_test
      end
    end

    context "when given commands before a PLACE command" do
      let(:commands) { ["MOVE", "MOVE", "LEFT", "MOVE", "PLACE 1,2,EAST", "REPORT"] }
      let(:expected_output) { "Output: 1,2,EAST" }

      it "ignores all commands before the PLACE command" do
        execute_test
      end
    end

    context "when given commands multiple PLACE commands" do
      let(:commands) { ["PLACE 0,0,SOUTH", "REPORT", "PLACE 1,2,EAST", "REPORT", "PLACE 3,4,WEST", "REPORT"] }
      let(:expected_output_after_first_place_command) { "Output: 0,0,SOUTH" }
      let(:expected_output_after_second_place_command) { "Output: 1,2,EAST" }
      let(:expected_output_after_third_place_command) { "Output: 3,4,WEST" }

      it "accepts all PLACE commands" do
        apply_commands

        expect(simulator).to receive(:report_output).with(expected_output_after_first_place_command)
        expect(simulator).to receive(:report_output).with(expected_output_after_second_place_command)
        expect(simulator).to receive(:report_output).with(expected_output_after_third_place_command)

        quit_simulator
        simulator.run
      end
    end

    context "when given unknown commands" do
      let(:commands) { ["A", "B", "B", "PLACE 1,2,EAST", "REPORT"] }
      let(:expected_output) { "Output: 1,2,EAST" }

      it "ignores all unknown commands" do
        execute_test
      end
    end

    context "when trying to move out of bounds" do
      let(:commands) { ["PLACE 0,1,SOUTH", "MOVE", "MOVE", "REPORT"] }
      let(:expected_output) { "Output: 0,0,SOUTH" }

      it "prevents from going out of bounds" do
        execute_test
      end
    end

    context "when given a mixture of known and unknown commands" do
      let(:commands) do
        [
          "PLACE 0,1,SOUTH", "MOVE", "MOVE", "RIGHT", "ABC", " ", "LEFT",
          "", "", "PLACE 4,4,WEST", "MOVE", "MOVE", "LEFT", "MOVE", "MOVE",
          "UNKNOWN", "mv", " ", "lft", "     ", "MOVE", "LEFT", "REPORT"
        ]
      end
      let(:expected_output) { "Output: 2,1,EAST" }

      it "ignores unknown commands and processes known commands" do
        execute_test
      end
    end
  end
end
