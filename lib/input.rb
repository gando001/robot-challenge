class Input
	attr_reader :args

	def initialize(args:)
		@args = args.split(',')
	end

	def command
		args.first
	end

	def command_args
		args.drop(1)
	end

	def command_class
		klass = "#{basename.capitalize}Command"
    return InvalidCommand unless Object.const_defined?(klass)

    Object.const_get(klass)
	end
end
