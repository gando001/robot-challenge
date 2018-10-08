require "spec_helper"
require "main"

describe Main do
  let(:main) { Main.new(rows: 5, columns: 5) }

  describe "#run" do
    let(:quit_command) { "QUIT" }

    it "stops when issued terminating command" do
      expect(main).to receive(:request_command).once.and_return(quit_command)

      main.run
    end

    context "when the command is empty" do
      it "continues to ask for commands until a command is given" do
        5.times do |_|
          expect(main).to receive(:request_command).and_return("")
        end

        expect(main).to receive(:request_command).and_return(quit_command)

        main.run
      end
    end

    context "when the command is known" do
      let(:command) { "move" }

      it "processes the command" do
        expect(main).to receive(:request_command).and_return(command)

        expect(main).to receive(:process_request).once.with(command)

        expect(main).to receive(:request_command).and_return(quit_command)
        expect(main).to receive(:process_request).once.with(quit_command)

        main.run
      end
    end
  end

  describe "integration tests" do
    context "simple commands; example 1" do
      let(:commands) { ["PLACE 0,0,NORTH", "MOVE", "REPORT", "QUIT"] }
      let(:expected_output) { "Output: 0,1,NORTH" }

      it "reports 0,1,NORTH" do
        commands.each do |command|
          expect(main).to receive(:request_command).and_return(command)
        end

        expect(main).to receive(:report_output).with(expected_output)

        main.run
      end
    end

    context "simple commands; example 2" do
      let(:commands) { ["PLACE 0,0,NORTH", "LEFT", "REPORT", "QUIT"] }
      let(:expected_output) { "Output: 0,0,WEST" }

      it "reports 0,0,WEST" do
        commands.each do |command|
          expect(main).to receive(:request_command).and_return(command)
        end

        expect(main).to receive(:report_output).with(expected_output)

        main.run
      end
    end

    context "simple commands; example 3" do
      let(:commands) { ["PLACE 1,2,EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT", "QUIT"] }
      let(:expected_output) { "Output: 3,3,NORTH" }

      it "reports 3,3,NORTH" do
        commands.each do |command|
          expect(main).to receive(:request_command).and_return(command)
        end

        expect(main).to receive(:report_output).with(expected_output)

        main.run
      end
    end

    context "when given commands before a PLACE command" do
      let(:commands) { ["MOVE", "MOVE", "LEFT", "MOVE", "PLACE 1,2,EAST", "REPORT", "QUIT"] }
      let(:expected_output) { "Output: 1,2,EAST" }

      it "ignores all commands before the PLACE command" do
        commands.each do |command|
          expect(main).to receive(:request_command).and_return(command)
        end

        expect(main).to receive(:report_output).with(expected_output)

        main.run
      end
    end

    context "when given commands multiple PLACE commands" do
      let(:commands) { ["PLACE 0,0,SOUTH", "REPORT", "PLACE 1,2,EAST", "REPORT", "QUIT"] }
      let(:expected_output_after_first_place_command) { "Output: 0,0,SOUTH" }
      let(:expected_output_after_second_place_command) { "Output: 1,2,EAST" }

      it "accepts all PLACE commands" do
        commands.each do |command|
          expect(main).to receive(:request_command).and_return(command)
        end

        expect(main).to receive(:report_output).with(expected_output_after_first_place_command)
        expect(main).to receive(:report_output).with(expected_output_after_second_place_command)

        main.run
      end
    end

    context "when given unknown commands" do
      let(:commands) { ["A", "B", "B", "PLACE 1,2,EAST", "REPORT", "QUIT"] }
      let(:expected_output) { "Output: 1,2,EAST" }

      it "ignores all unknown commands" do
        commands.each do |command|
          expect(main).to receive(:request_command).and_return(command)
        end

        expect(main).to receive(:report_output).with(expected_output)

        main.run
      end
    end

    context "when trying to move out of bounds" do
      let(:commands) { ["PLACE 0,1,SOUTH", "MOVE", "MOVE", "REPORT", "QUIT"] }
      let(:expected_output) { "Output: 0,0,SOUTH" }

      it "prevents from going out of bounds" do
        commands.each do |command|
          expect(main).to receive(:request_command).and_return(command)
        end

        expect(main).to receive(:report_output).with(expected_output)

        main.run
      end
    end

    context "when given a mixture of known and unknown commands" do
      let(:commands) do
        [
          "PLACE 0,1,SOUTH", "MOVE", "MOVE", "RIGHT", "ABC", " ", "LEFT",
          "", "", "PLACE 4,4,WEST", "MOVE", "MOVE", "LEFT", "MOVE", "MOVE",
          "UNKNOWN", "mv", " ", "lft", "     ", "MOVE", "LEFT", "REPORT", "QUIT"
        ]
      end
      let(:expected_output) { "Output: 2,1,EAST" }

      it "ignores unknown commands and processes known commands" do
        commands.each do |command|
          expect(main).to receive(:request_command).and_return(command)
        end

        expect(main).to receive(:report_output).with(expected_output)

        main.run
      end
    end
  end
end
