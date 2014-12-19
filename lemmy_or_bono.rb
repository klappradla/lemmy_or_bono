require 'json'
require './question'
require './answer'
require './game'

module LemmyOrBono
	CONFIG = 'assets/config.json'
	INTRO = 'assets/intro.txt'
  
  def self.load_config(file_path)
    config = IO.read(file_path)
    JSON.parse(config)
  end

  def self.init_game(config)
    Game.new(config['jack'], config['finish'], config['questions'])
  end

  def self.play
		config = LemmyOrBono.load_config(LemmyOrBono::CONFIG)
		game = LemmyOrBono.init_game(config)
		game.start
	end
end

LemmyOrBono::play

