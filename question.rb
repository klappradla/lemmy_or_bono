
module LemmyOrBono

	class Question
		TYPE_MULTIPLE_CHOICE = "abc"
		TYPE_SINGLE_CHOICE = "!"

		attr_reader :threshold, :text

		def initialize(threshold, text)
			@threshold = threshold
			@text = text
		end

		def render
			puts "render question"
			3
		end
	end


	class QuestionMultipleChoice < Question

		attr_reader :answers

		def initialize(threshold, text, answers)
			super(threshold, text)
			@answers = generate_answers(answers)			
		end


		private

		def generate_answers(answers_array)
			answers = {}
			answers_array.shuffle.each_with_index do |answer, index|
				answers[Answer::INDICES[index]] = Answer.new(answer['text'], answer['value'])
			end
			answers
		end
		
	end

	class QuestionSingleChoice < Question
			
	end	
end