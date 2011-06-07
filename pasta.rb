# Pasta - a pastebin like application
require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'
require 'dm-migrations'
require 'albino'
require 'net/http'

# Set path to sqlite3 database file
set :public, File.dirname(__FILE__) + '/static'
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://pasta.db')

# Model
class Paste
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String
  property :body, Text
  property :author, String
  property :created_at, DateTime
end

Paste.auto_upgrade!

set :haml, :format => :html5

get '/' do
  @pastes = Paste.last(5)
  haml :index
end

get '/:id' do |id|
  @paste = Paste.get(Integer(id))
  haml :paste
end

post '/' do
  request = Net::HTTP.post_form(URI.parse('http://pygments.appspot.com/'),
                                {'lang'=>params[:language], 
                                 'code'=>params[:body]}
                               )
  body = request.body

  if params[:title].empty?
    title = "Unknown"
  else
    title = params[:title] 
  end

  if params[:author].empty?
    author = "Unknown"
  else
    author = params[:author]
  end

  new_paste = Paste.create(
                           :title => title,
                           :author => author,
                           :body => body,
                           :created_at => Time.now
                           )
  redirect "/#{new_paste[:id]}"
end


