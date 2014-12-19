require './config'

module LemmyOrBono

	include Config
  
  def self.load_game_data(file_path)
    game_data = IO.read(file_path)
    JSON.parse(game_data)
  end

  def self.init_game(game_data)
    Game.new(Config::LIVES, Config::FINISH, game_data['questions'])
  end

  def self.play
		game_data = LemmyOrBono.load_game_data(Config::QUESTIONS_FILE)
		game = LemmyOrBono.init_game(game_data)
		game.start
	end
end

LemmyOrBono::play

