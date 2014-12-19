module LemmyOrBono

	class Game

		def initialize(jack, finish, questions_array)
			@jack = jack
			@finish = finish
			@questions = generate_questions(questions_array)
		end

		def start
			intro
			play
		end


		private

		def play
			while @jack < @finish
				progress = render_question
				die if !progress || @jack < 1
			end
			finish	
		end

		def generate_questions(questions_array)
		  questions = []
		  questions_array.shuffle.each do |q|
		    if q['type'] == Question::TYPE_MULTIPLE_CHOICE
		      questions.push(QuestionMultipleChoice.new(q['threshold'], q['text'], q['answers']))
		    else
		      questions.push(QuestionSingleChoice.new(q['threshold'], q['text'], q['range']))
		    end
		  end
		  questions
		end

		def render_question
			@questions.each do |question|
				if question.threshold <= @jack
					@jack += @questions.delete(question).render
					puts "current jack: #{@jack}"
					return true
				end
			end
			false
		end

		def die
			puts IO.read(LemmyOrBono::Config::DEATH).colorize(:cyan)
			exit(0)
		end

		def finish
			puts "You won. #{@questions.length} questions left over."
			puts IO.read(LemmyOrBono::Config::WIN).colorize(:cyan)
		end

		def intro
			puts "\n- Welcome to 'Lemmy or Bono'! -".colorize(:cyan).bold
			puts IO.read(LemmyOrBono::Config::INTRO).colorize(:cyan)
		end
		
	end
	
end