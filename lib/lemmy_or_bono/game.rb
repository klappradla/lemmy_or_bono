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
		  questions_array.shuffle.each do |question|
		    if question['type'] == Question::TYPE_MULTIPLE_CHOICE
		      questions << QuestionMultipleChoice.new(question)
		    else
		      questions << QuestionSingleChoice.new(question)
		    end
		  end
		  questions
		end

		def render_question
			@questions.each do |question|
				if question.threshold <= @jack
					@jack += @questions.delete(question).render
					stats
					return true
				end
			end
			false
		end

		def die
			puts IO.read(Config::DEATH).colorize(:cyan)
			exit(0)
		end

		def finish
			puts IO.read(Config::WIN).colorize(:cyan)
			#puts "#{@questions.length} questions left over."
		end

		def intro
			welcome = IO.readlines(Config::INTRO).first
			print "\n#{welcome}".colorize(:cyan).bold
			puts IO.read(Config::INTRO, nil, welcome.length).colorize(:cyan)
		end

		def stats
			puts "\t\t# jacks: #{@jack}\t\t\t".colorize(color: :black, background: :cyan)
		end
		
	end
	
end