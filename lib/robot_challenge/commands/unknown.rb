require_relative "base"

module Commands
  class Unknown < Base
    def process
    end

    private

    def valid?
      true
    end
  end
end
