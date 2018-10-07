require "spec_helper"
require "user_interface"

describe UserInterface do
	let(:interface) { UserInterface.new }

	describe "#greeting" do
		it "displays a message to the user" do
			expect { interface.greeting }.to output("Welcome!\n").to_stdout
		end
	end

	describe "#request_command" do
		it "displays a message asking the user to enter a command" do
			expect { interface.request_command }.to output("Enter a command\n").to_stdout
		end
	end
end
