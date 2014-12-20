require './config'

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

LemmyOrBono::init_game

