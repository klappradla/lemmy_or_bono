require 'JSON'

module LemmyOrBono

  class Game

    def initialize(file_path)
      config_file = IO.read(file_path)
      @content = JSON.parse(config_file)
      #@points = 0
      @jack = @content['jack']
    end

    def start
      render_ascii(@content['greeting'])
      game_loop(@content['questions'])
    end


    private

    def game_loop(questions)
      goal = @content['win']['threshold']

      while @jack < goal
        step = false
        questions.each do |question|

          if question['threshold'] < @jack
            step = true
            @jack += (render_question(question))
            puts @jack
          end
        end

        if !step || @jack < 1
          render_ascii(@content['loose'])
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
      render_question_jack(question)
    end

    def render_question_abc(question)
      i = ['a', 'b', 'c']
      puts question['question']
      answers = question['answers']
      answers.each_with_index do |answer, index|
        puts "\t" + i[index] + ") " + answer['answer']
      end

      choice = 'z'
      while !i.include? choice
        print "> "
        choice = STDIN.gets.chomp
      end

      return answers[i.index(choice)]['value'].to_i


    end

    def render_question_jack(question)

    end

  end
end


game = LemmyOrBono::Game.new('assets/lemmy_or_bono.json')
game.start
