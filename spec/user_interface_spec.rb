require "spec_helper"
require "user_interface"

describe UserInterface do
	let(:interface) { UserInterface.new }

	describe "#request_command" do
		it "displays a message asking the user to enter a command" do
			expect { interface.request_command }.to output("Enter a command\n").to_stdout
		end
	end

	describe "#write_message" do
		it "displays the given message to standard out" do
			expect { interface.write_message("ABC") }.to output("ABC\n").to_stdout
		end
	end
end
