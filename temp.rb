require 'JSON'

module LemmyOrBono

  class Game

    def initialize(file_path)
      config_file = IO.read(file_path)
      @content = JSON.parse(config_file)
    end

    def start
      render_ascii(@content['greeting'])
      game_loop(@content['questions'])
    end


    private

    def game_loop(questions)
      jack = @content['jack']
      goal = @content['win']['threshold']

      while jack < goal
        step = false

        questions.each do |question|
          if question['threshold'] < jack
            step = true
            jack += (render_question(question))
            puts jack
          end
        end

        if !step || jack < 1
          render_ascii(@content['loose'])
          exit(0)
        end
      end
      render_ascii(@content['win']['file'])
    end

    def render_ascii(file_path)
      output = IO.read(file_path)
      puts output
    end

    def render_question(question)
      if question['type'] == 1
        return render_question_abc(question)
      end
      return render_question_jack(question)
    end

    def render_question_abc(question)
      options = ('a'..'c').to_a
      answers = question['answers']

      puts question['question']
      answers.each_with_index do |answer, index|
        puts options[index] + ") " + answer['text']
      end

      answers[user_input(options)]['value'].to_i
    end

    def render_question_jack(question)

    end

    def user_input(options)
      print "> "
      choice = STDIN.gets.chomp
      return options.index(choice) if options.include? choice
      user_input(options)
    end

  end
end


game = LemmyOrBono::Game.new('assets/lemmy_or_bono.json')
game.start
