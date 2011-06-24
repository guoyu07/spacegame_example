require 'rubygems'
require 'pusher'
require 'sinatra'
require 'uuid'

<<<<<<< HEAD
Pusher.app_id = '5207'
Pusher.key = '5d01c573aff20a7f976b'
Pusher.secret = '8b8ad0d9fbb525c05579'
=======
Pusher.app_id = '6477'
Pusher.key = '83d652b1c3204e365939'
Pusher.secret = '5d1c2e1eef265f638e6f'
>>>>>>> 40c90d4fe300cad34889834df53ece74f812b838

# Pusher['things'].trigger('thing-create', 'foo')
enable :sessions
set :public, File.join(File.dirname(__FILE__), 'public')

get '/' do
  return File.open("public/login.html") unless session['name']
  session['foo_id'] = UUID.generate
  template = File.open("public/index.html").read
  puts :sub, session['foo_id']
  template = template.gsub(/USERID/, session['foo_id'])
  template = template.gsub(/USERNAME/, session['name'])
  return template
end

post '/register' do
  session['name'] = params[:name]
  redirect '/'
end

post '/pusher/auth' do
  puts :auth, session['foo_id']
  puts params[:channel_name]
  Pusher[params[:channel_name]].authenticate(params[:socket_id], {
    :user_id => session['foo_id'],
    :user_info => {
      :name => session['name']
    }
  }).to_json
end
