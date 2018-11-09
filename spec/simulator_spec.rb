require_relative "spec_helper"
require_relative "../lib/robot_challenge/table"
require_relative "../lib/robot_challenge/robot"
require_relative "../lib/robot_challenge/user_interface"
require_relative "../lib/robot_challenge/simulator"

describe Simulator do
  let(:simulator) do
    Simulator.new(
      table: table,
      robot: robot,
      user_interface: user_interface
    )
  end
  let(:quit_command) { "QUIT" }

  def quit_simulator
    expect(simulator).to receive(:request_command).and_return(quit_command)
  end

  describe "#run" do
    let(:table) { instance_double("Table") }
    let(:robot) { instance_double("Robot") }
    let(:user_interface) { instance_double("UserInterface") }

    it "stops when issued a terminating command" do
      expect(simulator).to receive(:request_command).once.and_return(quit_command)

      simulator.run
    end
  end

  describe "integration tests" do
    let(:table) { Table.new }
    let(:robot) { Robot.new }
    let(:user_interface) { UserInterface.new }

    def apply_commands
      commands.each do |command|
        expect(simulator).to receive(:request_command).and_return(command)
      end
    end

    def check_output
      expected_outputs.each do |e|
        expect(simulator).to receive(:report_output).with(e)
      end
    end

    def execute_test
      apply_commands
      check_output

      quit_simulator
      simulator.run
    end

    context "simple commands; example 1" do
      let(:commands) { ["PLACE 0,0,NORTH", "MOVE", "REPORT"] }
      let(:expected_outputs) { ["Output: 0,1,NORTH"] }

      it "reports 0,1,NORTH" do
        execute_test
      end
    end

    context "simple commands; example 2" do
      let(:commands) { ["PLACE 0,0,NORTH", "LEFT", "REPORT"] }
      let(:expected_outputs) { ["Output: 0,0,WEST"] }

      it "reports 0,0,WEST" do
        execute_test
      end
    end

    context "simple commands; example 3" do
      let(:commands) { ["PLACE 1,2,EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT"] }
      let(:expected_outputs) { ["Output: 3,3,NORTH"] }

      it "reports 3,3,NORTH" do
        execute_test
      end
    end

    context "when given commands before a PLACE command" do
      let(:commands) { ["MOVE", "MOVE", "LEFT", "REPORT", "MOVE", "PLACE 1,2,EAST", "REPORT"] }
      let(:expected_outputs) { [nil, "Output: 1,2,EAST"] }

      it "ignores all commands before the PLACE command" do
        execute_test
      end
    end

    context "when given commands multiple PLACE commands" do
      let(:commands) { ["PLACE 0,0,SOUTH", "REPORT", "PLACE 1,2,EAST", "REPORT", "PLACE 3,4,WEST", "REPORT"] }
      let(:expected_outputs) { ["Output: 0,0,SOUTH", "Output: 1,2,EAST", "Output: 3,4,WEST"] }

      it "accepts all PLACE commands" do
        execute_test
      end
    end

    context "when given unknown commands" do
      let(:commands) { ["A", "B", "1244", "A(*(@#@#}{>>>,...AS", "PLACE 1,2,EAST", "REPORT"] }
      let(:expected_outputs) { ["Output: 1,2,EAST"] }

      it "ignores all unknown commands" do
        expect(simulator).to receive(:report_output).with("Unknown command!").exactly(4).times

        execute_test
      end
    end

    context "when trying to move out of bounds" do
      let(:commands) { ["PLACE 0,1,SOUTH", "MOVE", "MOVE", "REPORT"] }
      let(:expected_outputs) { ["Output: 0,0,SOUTH"] }

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
      let(:expected_outputs) { ["Output: 2,1,EAST"] }

      it "ignores unknown commands and processes known commands" do
        expect(simulator).to receive(:report_output).with("Unknown command!").exactly(9).times

        execute_test
      end
    end

    context "when given commands multiple BLOCK commands" do
      let(:commands) { ["BLOCK 0,0", "BLOCK 1,2", "BLOCK 3,4"] }
      let(:expected_outputs) { [] }

      it "accepts all BLOCK commands" do
        execute_test

        expect(table.obstacles.count).to be 3
      end
    end

    context "when trying to place the robot onto a blocked cell" do
      let(:commands) { ["BLOCK 0,0", "PLACE 0,0,NORTH", "REPORT", "PLACE 1,1,NORTH", "REPORT"] }
      let(:expected_outputs) { [nil, "Output: 1,1,NORTH"] }

      it "prevents placing the robot onto a block position" do
        execute_test
      end
    end

    context "when trying to move to a blocked cell" do
      let(:commands) { ["PLACE 0,0,NORTH", "REPORT", "BLOCK 0,1", "MOVE", "REPORT"] }
      let(:expected_outputs) { ["Output: 0,0,NORTH", "Output: 0,0,NORTH"] }

      it "prevents the robot moving to a block position" do
        execute_test
      end
    end
  end
end
