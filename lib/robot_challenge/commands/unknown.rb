require_relative "base"

module Command
  class Unknown < Base
    def process
    end

    private

    def valid?
      true
    end
  end
end
