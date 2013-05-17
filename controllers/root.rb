get '/' do
  'Hello Sinatra!'
end

get '/rabl' do
  rabl :foo, :format => 'json'
end

get '/user/seed' do
  User.create :name => 'Pieux Xi'
  'succeed!'
end

get '/user/all' do
  @users =User.all
  rabl :users, :format => 'json'
end
