get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/game/new' do
  game = NewGame.init
  session[:player_id] = game.game.player1_id
  session[:game_id] = game.game.id
end

get '/game/:id' do
  game = CurrentGame.new(params[:id])
  session[:player_id] = game.game.player2_id
  session[:game_id] = game.game.id
end

get '/cookie' do 
  session.inspect
end

class CurrentGame
  attr_reader :game
  def initialize(id)
    @game = Game.find(id)
    init_player2
  end

  def init_player2
    @game.player2_id = Player.create.id
    @game.save
  end
end

class NewGame
  attr_reader :game
  def self.init
    self.new
  end

  def initialize
    init_game
    init_player
  end

  def init_game
    @game = Game.create
  end

  def init_player
    @game.player1_id = Player.create.id
    @game.save
  end
end

