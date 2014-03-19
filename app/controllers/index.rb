get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/cookie' do 
  session.inspect
end