module LemmyOrBono

	class Question
		TYPE_MULTIPLE_CHOICE = "abc"
		TYPE_SINGLE_CHOICE = "!"

		attr_reader :threshold

		def initialize(threshold, text)
			@threshold = threshold
			@text = text
		end

		def render
			puts @text
		end

		
		private

		def get_user_input(range)
			print "> "
      choice = STDIN.gets.chomp
      return choice if range.include? choice
      user_input(range)
		end
	end


	class QuestionMultipleChoice < Question
		KEYS = [:a, :b, :c]

		attr_reader :answers

		def initialize(threshold, text, answers)
			super(threshold, text)
			@answers = generate_answers(answers)			
		end

		def render
			super()
			render_answers
			choice = get_user_input(KEYS.map(&:to_s)).to_sym
			@answers[choice].value
		end


		private

		def generate_answers(answers_array)
			answers = {}
			answers_array.shuffle.each_with_index do |answer, index|
				answers[KEYS[index]] = Answer.new(answer['text'], answer['value'])
			end
			answers
		end

		def render_answers
			@answers.each { |key, answer| answer.render(key) }
		end
		
	end

	class QuestionSingleChoice < Question
			
	end	
end