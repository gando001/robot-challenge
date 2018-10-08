require_relative "base"
require_relative "../position"

class Left < Base
  def process
    next_position = Position.new(
      x: robot.position.x,
      y: robot.position.y,
      orientation: orientation_on_left(robot.position.orientation)
    )

    robot.move_to(next_position)
  end

  private

  def valid?
    robot.valid_position?
  end

  def orientation_on_left(orientation)
    case orientation
      when Position::NORTH then Position::WEST
      when Position::WEST  then Position::SOUTH
      when Position::SOUTH then Position::EAST
      else 			 								Position::NORTH
    end
  end
end
