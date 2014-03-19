get '/session/new' do
  erb :login
end

post '/session/create' do
  username = params[:username]
  user = User.authenticate(username, params[:password])

  if user
    session[:user_id] = user.id
    redirect to '/'
  else
    @error = "invalid email or password"
    erb :login
  end
end

get '/session/delete' do
  clear_user
  redirect to '/'
end

get '/users/new' do
  erb :signup
end

post '/users/create' do
  user = User.create(username: params[:username],
                     password: params[:password])
  if user
    session[:user_id] = user.id
    redirect to '/'
  else
    @error = "invalid email or password"
    erb :signup
  end
end