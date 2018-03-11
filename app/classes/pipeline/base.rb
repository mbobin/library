module Pipeline
  class Base
    def self.call(*args)
      new.call(*args)
    end

    def initialize
      @options = {}
    end

    def call(options = {})
      @options.merge!(options)
      return @options if halted?

      execute
      @options
    end

    def halted_reason
      @options["halted_reason"]
    end

    private

    def halt!(reason = nil)
      @options["halted"] = true
      @options["halted_reason"] = reason if reason
      @options["halted_from"] = self.class.name
      @options
    end

    def halted?
      !!@options["halted"]
    end

    def execute
    end
  end
end
