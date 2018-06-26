
require 'sinatra'

enable :sessions

NUMBER = 'good'
def go
@files = File.readlines("five_desk.txt")
@pick = @files.select { |w| w.size > 5 && w.size < 12 }.sample

@secret_word = @pick
@secret_word.downcase!
end

get '/' do
  @files = File.readlines("five_desk.txt")
  @pick = @files.select { |w| w.size > 5 && w.size < 12 }.sample

  @secret_word = @pick
  @secret_word.downcase!

@session = session[:number] = @secret_word
@@guessesz = session[:guessesz] = 11


erb :index
end

get '/outplause' do
@session = session[:number]
if  @session.include?(params[:guess])
  #session[:number].include?(params[:guess])
  @message = 'Yes'
  erb :come
else
  @message = 'No'
  @@guessesz -= 1
  erb :come

end
# erb :come


end
