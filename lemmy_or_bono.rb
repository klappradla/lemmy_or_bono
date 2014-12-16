require 'json'
require './question'
require './answer'
require './game'

module LemmyOrBono
  
  def self.load_config(file_path)
    config = IO.read(file_path)
    JSON.parse(config)
  end

  def self.init_game(config)
    Game.new(config['jack'], config['finish'], config['questions'])
  end

end

config = LemmyOrBono.load_config('config.json')
game = LemmyOrBono.init_game(config)
game.play
#a = LemmyOrBono::Answer.new(config['questions'][1]['answers'].first)
#puts a.text, a.value

