require_relative "spec_helper"
require_relative "../lib/robot_challenge/position"

describe Position do
  let(:orientation) { Position::NORTH }
  let(:position) { Position.new(x: 0, y: 0, orientation: orientation) }

  describe "#to_s" do
    it "returns the position as a string" do
      expect(position.to_s).to eq("Output: 0,0,NORTH")
    end
  end

  describe "#valid_orientation?" do
    context "when the position orientation is not valid" do
      let(:orientation) { "ABC" }

      it "returns false" do
        expect(position.valid_orientation?).to be false
      end
    end

    context "when the position orientation is valid" do
      it "returns false" do
        expect(position.valid_orientation?).to be true
      end
    end
  end

  describe "#located_at?" do
    context "when the given positions location matches the positions location" do
      it "returns true" do
        expect(position.located_at?(position)).to be true
      end
    end

    context "when the given positions location does not match the positions location" do
      let(:another_position) { Position.new(x: 10, y: 0, orientation: orientation) }

      it "returns false" do
        expect(position.located_at?(another_position)).to be false
      end
    end
  end
end
