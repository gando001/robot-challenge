require_relative "spec_helper"
require_relative "../lib/robot_challenge/table"
require_relative "../lib/robot_challenge/obstacle"

describe Table do
  describe "#within_bounds?" do
    subject(:within_bounds) { table.within_bounds?(position) }

    context "when the table uses the default rows and columns" do
      let(:table) { Table.new }

      context "when the position is within bounds" do
        context "when the position is the south west corner" do
          let(:position) { Position.new(x: 0, y: 0, orientation: Position::NORTH) }

          it "returns true" do
            expect(within_bounds).to be true
          end
        end

        context "when the position is the north east corner" do
          let(:position) { Position.new(x: 4, y: 4, orientation: Position::NORTH) }

          it "returns true" do
            expect(within_bounds).to be true
          end
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

    context "when the table uses the given rows and columns" do
      let(:table) { Table.new(rows: 5, columns: 10) }

      context "when the position is within bounds" do
        context "when the position is the south west corner" do
          let(:position) { Position.new(x: 0, y: 0, orientation: Position::NORTH) }

          it "returns true" do
            expect(within_bounds).to be true
          end
        end

        context "when the position is the north east corner" do
          let(:position) { Position.new(x: 4, y: 9, orientation: Position::NORTH) }

          it "returns true" do
            expect(within_bounds).to be true
          end
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

  describe "#obstacle_at?" do
    let(:position) { Position.new(x: 0, y: 0, orientation: Position::NORTH) }
    let(:table) { Table.new }

    context "when there are no obstacles at the given position" do
      it "returns false" do
        expect(table.obstacle_at?(position)).to be false
      end
    end

    context "when there is an obstacle at the given position" do
      before do
        table.obstacles.push(Obstacle.new(position: position))
      end

      it "returns true" do
        expect(table.obstacle_at?(position)).to be true
      end
    end
  end
end
