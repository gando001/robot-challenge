require "spec_helper"
require "commands/base"

describe Base do
	let(:command) { Base.new(args: nil, robot: nil) }

	describe "#execute" do
		context "when the command is invalid" do
			it "raises no error" do
				expect(command).to receive(:valid?).and_return(false)

				expect { command.execute }.not_to raise_error
			end
		end

		context "when the command is valid" do
			it "raises an error" do
				expect(command).to receive(:valid?).and_return(true)

				expect { command.execute }.to raise_error(NotImplementedError)
			end
		end
	end
end