require_relative "spec_helper"
require_relative "../lib/robot_challenge/obstacle"

describe Obstacle do
  let(:orientation) { Position::NORTH }
  let(:position) { Position.new(x: 0, y: 0, orientation: orientation) }
  let(:obstacle) { Obstacle.new(position: position) }

  describe "#located_at?" do
    context "when there is an obstacle at the given position" do
      it "returns true" do
        expect(obstacle.located_at?(position)).to be true
      end
    end

    context "when there is no obstacle at the given position" do
      let(:another_position) { Position.new(x: 10, y: 10, orientation: orientation) }

      it "returns false" do
        expect(obstacle.located_at?(another_position)).to be false
      end
    end
  end
end
