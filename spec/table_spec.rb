require_relative "spec_helper"
require_relative "../lib/robot_challenge/table"

describe Table do
  let(:table) { Table.new(rows: 5, columns: 5) }

  describe "#within_bounds?" do
    subject(:within_bounds) { table.within_bounds?(position) }

    context "when the position is within bounds" do
      let(:position) { Position.new(x: 0, y: 0, orientation: Position::NORTH) }

      it "returns true" do
        expect(within_bounds).to be true
      end
    end

    context "when the row position is not within bounds" do
      let(:position) { Position.new(x: -1, y: 0, orientation: Position::NORTH) }

      it "returns false" do
        expect(within_bounds).to be false
      end
    end

    context "when the column position is not within bounds" do
      let(:position) { Position.new(x: 0, y: -1, orientation: Position::NORTH) }

      it "returns false" do
        expect(within_bounds).to be false
      end
    end
  end
end
