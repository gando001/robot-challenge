require_relative "base"

class Place < Base
  def process
    robot.move_to(next_position)
  end

  private

  def valid?
    position_on_table?(next_position)
  end

  def next_position
    @next_position ||= Position.new(x: args[0]&.to_i, y: args[1]&.to_i, orientation: args[2]&.downcase)
  end
end
