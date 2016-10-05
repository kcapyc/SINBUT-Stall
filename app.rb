require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# админка 1/1
configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Вход с паролем'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Вам необходимо войти для доступа к ' + request.path
    halt erb(:login_form)
  end
end
# админка 1/1

set :database, "sqlite3:stall.db"

class Products < ActiveRecord::Base
end

class Order < ActiveRecord::Base
end

get '/' do
	@product = Products.all # выбираем все записи из таблицы
	erb :index
end

# админка 2/2
get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
	@username = params[:username]
	@pass = params[:pass]

	if @pass == 'love'
		  session[:identity] = params['username']
		  where_user_came_from = session[:previous_url] || '/'
		  redirect to where_user_came_from
	else
		@error = 'Доступ запрещен'
		return erb :login_form
	end

end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Вы вышли</div>"
end

get '/secure/place' do
	@order = Order.order('created_at DESC')
	erb :orderlist
end
# админка 2/2

get '/css' do
	erb :page
end

get '/about' do
	erb :about
end

post '/add_order' do
	@order = Order.create params[:order]
	erb :add_order
end

post '/cart' do
	@order_input = params[:order_input]
	@items = parse_order @order_input

	if @items.length == 0
		return erb :cart_empty
	end

	@items.each do |item|
		# id, cnt
		item[0] = Products.find(item[0])
	end

	erb :cart
end

def parse_order order_input

	s1 = order_input.split(',')
	arr = []

	s1.each do |i|
		s2 = i.split('=')
		s3 = s2[0].split('_')

		id = s3[1]
		cnt = s2[1]

		arr2 = [id, cnt]
		arr.push arr2
	end

	return arr
end