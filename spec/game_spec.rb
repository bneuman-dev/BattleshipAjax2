require_relative 'spec_helper'

describe 'When joining a new game' do

  let(:browser) { Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))}
  
  it "game is initialized" do
    expect { browser.get '/game/new' }.to change { Game.all.empty? }.from(true).to(false)
  end

  it "player is initialized and set as Player 1" do
    expect { browser.get '/game/new'}.to change { Player.all.empty? }.from(true).to(false)
    expect(Game.first.player1_id).to eq 1
  end

  it "joining open game sets you as Player 2" do
    game = NewGame.init
    expect { browser.get '/game/1'}.to change { Player.find_by(id: 2).nil?}.from(true).to(false)
    expect(Game.first.player2_id).to eq 2
  end

  it "starting new game sets player_id in session" do
    browser.get '/game/new'
    expect(browser.last_request.session[:player_id]).to eq 1
  end

  it "joining open game sets player_id in session correctly" do
    game = NewGame.init
    browser.get '/game/1'
    expect(browser.last_request.session[:player_id]).to eq 2
  end

  it "starting new game sets game_id in session" do
    browser.get '/game/new'
    expect(browser.last_request.session[:game_id]).to eq 1
  end

  it "joining game in progress sets game_id in session" do
    game = NewGame.init
    browser.get '/game/1'
    expect(browser.last_request.session[:game_id]).to eq 1
  end

end

# feature "Testing cookies" do
#   let(:browser) { Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))}

#   it "starting new game sets users cookie with game_id and player_id" do
#     # browser.get '/game/new'
#     # # expect(browser.last_response["Set-Cookie"]).to eq "user_id=1"
#     # browser.get '/cookie'
#     browser.visit '/game/new'
#     browser.visit '/cookie'
#     expect(browser.page).to have_content("user_id => 1")
#   end
# end