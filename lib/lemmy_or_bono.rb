require 'rubygems'
require 'bundler/setup'
Bundler.require(:default) # require all gems from gemfile

$LOAD_PATH << File.dirname(__FILE__) # require all relative
require 'lemmy_or_bono/config'
require 'lemmy_or_bono/question'
require 'lemmy_or_bono/answer'
require 'lemmy_or_bono/game'

module LemmyOrBono
  
  def self.load_game_data(file_path)
    game_data = IO.read(file_path)
    JSON.parse(game_data)
  end

  def self.init_game
  	game_data = LemmyOrBono.load_game_data(Config::GAME_DATA)
    Game.new(Config::LIVES, Config::FINISH, game_data['questions']).start
  end
end