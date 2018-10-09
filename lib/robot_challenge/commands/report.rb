require_relative "base"

module Command
  class Report < Base
    def process
      robot.position.to_s
    end

    private

    def valid?
      robot.valid_position?
    end
  end
end
