require_relative "base"

module Commands
  class Place < Base
    def process
      robot.move_to(next_position)
    end

    private

    def valid?
      valid_place_arguments? && position_on_table?(next_position)
    end

    def next_position
      @next_position ||= Position.new(x: x_position, y: y_position, orientation: orientation_arg)
    end

    def valid_place_arguments?
      !!(x_position && y_position && orientation_arg)
    end

    def x_position
      args[0]&.to_i
    end

    def y_position
      args[1]&.to_i
    end

    def orientation_arg
      args[2]&.downcase
    end
  end
end
