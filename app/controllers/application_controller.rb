require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
	@user = User.find_by username: params[:username]
	if @user
		session[:user_id]=@user.id
		redirect '/account'
	end
	erb :error
  end

  get '/account' do
	@session = session
	Helpers.is_logged_in?(session) ? (erb :account) : (erb :error)
  end

  get '/logout' do
	session.clear
	redirect '/'
  end


end

