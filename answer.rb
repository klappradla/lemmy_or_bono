module LemmyOrBono

	class Answer
		attr_reader :value

		def initialize(text, value)
			@text = text
			@value = value
		end

		def render(key = '')
			puts "#{key}) #{@text}"
		end
		
	end
	
end