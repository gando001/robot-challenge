class UserInterface
  def request_command
    write_message("Enter a command")
  end

  def read_command
    STDIN.gets
  end

  def write_message(message)
    puts message
  end
end
