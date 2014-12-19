module LemmyOrBono

	class Answer
		attr_reader :value

		def initialize(text, value)
			@text = text
			@value = value
		end

		def render(key = '')
			puts "#{key})".colorize(:cyan).bold + " #{@text}".colorize(:cyan)
		end
		
	end
	
end