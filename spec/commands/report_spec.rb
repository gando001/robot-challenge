require_relative "../spec_helper"
require_relative "../../lib/robot_challenge/commands/report"
require_relative "../../lib/robot_challenge/robot"

describe Report do
  let(:position) { Position.new(x: 2, y: 2, orientation: Position::NORTH) }
  let(:robot) { Robot.new(position: position) }
  let(:command) { Report.new(args: nil, table: nil, robot: robot) }

  describe "#process" do
    context "when the command is invalid" do
      it "does not report the robots position" do
        expect(command).to receive(:valid?).and_return(false)

        expect(position).to_not receive(:to_s)

        command.execute
      end
    end

    context "when the command is valid" do
      before do
        expect(command).to receive(:valid?).and_return(true)
      end

      it "returns the robots position" do
        expect(command.execute).to eq("Output: 2,2,NORTH")
      end
    end
  end
end
