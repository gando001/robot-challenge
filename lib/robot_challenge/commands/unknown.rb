require_relative "base"

module Commands
  class Unknown < Base
    def process
      "Unknown command!"
    end

    private

    def valid?
      true
    end
  end
end
