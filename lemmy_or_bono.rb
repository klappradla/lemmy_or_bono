require 'json'
require './question.rb'
require './answer.rb'

module LemmyOrBono
  
  def self.load_config(file_path)
    config = IO.read(file_path)
    JSON.parse(config)
  end

  def self.init_game(config)
    questions = self.generate_questions(config['questions'])

    questions.each do |q|
      puts q.answers.keys
    end
    #puts config['questions'][1]['answers']
    #puts config['questions'][1]['answers'].shuffle
  end

  def self.generate_questions(questions_array)
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

config = LemmyOrBono.load_config('config.json')
LemmyOrBono.init_game(config)
#a = LemmyOrBono::Answer.new(config['questions'][1]['answers'].first)
#puts a.text, a.value

