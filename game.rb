module LemmyOrBono

	class Game

		attr_accessor :jack
		attr_reader :finish, :questions

		def initialize(jack, finish, questions_array)
			@jack = jack
			@finish = finish
			@questions = generate_questions(questions_array)
		end

		def generate_questions(questions_array)
		  questions = []
		  questions_array.each do |q|
		    if q['type'] == Question::TYPE_MULTIPLE_CHOICE
		      questions.push(QuestionMultipleChoice.new(q['threshold'], q['text'], q['answers']))
		    else
		      #questions.push(QuestionSingleChoice.new(q['threshold'], q['text'], q['value']))
		    end
		  end
		  questions
		end
		
	end
	
end