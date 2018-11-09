require_relative "base"
require_relative "../obstacle"

module Commands
  class Block < Base
    def process
      return if robot_at_position?

      table.obstacles.push(obstacle) unless table.obstacle_at?(next_position)
    end

    private

    def valid?
      valid_obstacle_arguments? && position_on_table?(next_position)
    end

    def next_position
      @next_position ||= Position.new(x: x_position, y: y_position, orientation: Position::NORTH)
    end

    def valid_obstacle_arguments?
      !!(x_position && y_position)
    end

    def x_position
      args[0]&.to_i
    end

    def y_position
      args[1]&.to_i
    end

    def obstacle
      @obstacle ||= Obstacle.new(position: next_position)
    end

    def robot_at_position?
      robot.valid_position? && next_position.located_at?(robot.position)
    end
  end
end
