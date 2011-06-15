# Pasta - a pastebin like application
require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'
require 'dm-migrations'
require 'albino'
require 'net/http'
require 'uv'

# Set path to sqlite3 database file
set :public, File.dirname(__FILE__) + '/static'
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://pasta.db')

# Model
class Paste
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String
  property :body, Text
  property :bodywlines, Text
  property :rawbody, Text
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

get '/lnos/:id' do |id|
  @paste = Paste.get(Integer(id))
  haml :pastewlines
end

get '/raw/:id' do |id|
  @paste = Paste.get(Integer(id))
  haml :raw
end

get '/download/:id' do |id|
  @paste = Paste.get(Integer(id))
  if @paste.title != "Untitled"
    @fname = @paste.title
  else
    @fname = 'paste' + id + '.txt'
  end

  # There's probably a better way to do this..
  File.open(File.dirname(__FILE__) + "/static/rraw/#{id}", 'w') {|f| f.write(@paste.rawbody) }
  send_file File.dirname(__FILE__) + "static/rraw/#{id}", :type => :txt, :filename => @fname
end

post '/' do

  # This is a nasty hack :(
  if params[:language] == "bash"
    @lang = "shell-unix-generic"
  else
    @lang = params[:language]
  end

  rawbody = params[:body]
  body = Uv.parse(params[:body], "xhtml", @lang, false, "eiffel")
  bodywlines = Uv.parse(params[:body], "xhtml", @lang, true, "eiffel")

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
                           :rawbody => rawbody,
                           :body => body,
                           :bodywlines => bodywlines,
                           :created_at => Time.now
                           )
  redirect "/#{new_paste[:id]}"
end


