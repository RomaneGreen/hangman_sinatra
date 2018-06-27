
require 'sinatra'

enable :sessions

get '/' do

@files = File.readlines("five_desk.txt")
@pick = @files.select { |w| w.size > 5 && w.size < 12 }.sample
@secret_word = @pick
@secret_word.downcase!

@session = session[:word] = @secret_word
@@guessesz = session[:guessesz] = 10
  @image = "images/10.jpg"
erb :index
end

get '/output' do
@session = session[:word]
if  @session.include?(params[:guess])
    @message = 'Correct'
    @image = "images/"+@@guessesz.to_s+".jpg"
  erb :result
else
  @message = 'Incorrect'
  @@guessesz -= 1
  @image = "images/"+@@guessesz.to_s+".jpg"
  erb :result
end

end
