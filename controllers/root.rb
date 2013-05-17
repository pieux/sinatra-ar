get '/' do
  'Hello Sinatra!'
end

get '/rabl' do
  rabl :foo, :format => "json"
end
