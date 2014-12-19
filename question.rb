module LemmyOrBono

	class Question
		TYPE_MULTIPLE_CHOICE = "abc"

		attr_reader :threshold

		def initialize(threshold, text)
			@threshold = threshold
			@text = text
		end

		def render
			puts "\n#{@text}".colorize(:magenta)
			render_answers
		end

		
		private

		def get_user_input(range)
			print "> ".colorize(:magenta).bold
      choice = STDIN.gets.chomp
      if range.include? choice
      	return choice
      else
      	puts "Huh?".colorize(:magenta).bold
      	get_user_input(range)
      end
		end
	end


	class QuestionMultipleChoice < Question
		KEYS = [:a, :b, :c]

		def initialize(threshold, text, answers)
			super(threshold, text)
			@answers = generate_answers(answers)			
		end

		def render
			super()
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

		def initialize(threshold, text, range)
			super(threshold, text)
			@range = (range.first..range.last).to_a
		end

		def render
			super()
			choice = get_user_input(@range.map(&:to_s)).to_i
			randomize_impact(choice)
		end


		private

		def render_answers
			puts "Choose value between #{@range.first} and #{@range.last}".colorize(:cyan)
		end

		def randomize_impact(value)
			#(value * Random.rand(-1..1) * Random.rand(0.5..2.5)).round
			value * Random.rand(-1..1)
		end
			
	end	
end