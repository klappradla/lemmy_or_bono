module LemmyOrBono

	class Answer
		INDICES = [:a, :b, :c]
		attr_reader :text, :value

		def initialize(text, value)
			@text = text
			@value = value
		end
		
	end
	
end