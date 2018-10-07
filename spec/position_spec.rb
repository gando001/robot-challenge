require "spec_helper"
require "position"

describe Position do
	let(:position) { Position.new(x: 0, y: 0, orientation: Position::NORTH) }

	describe "#to_s" do
		it "returns the position as a string" do
			expect(position.to_s).to eq("Output: 0, 0, NORTH")
		end
	end
end
