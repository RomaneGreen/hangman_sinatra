
require 'sinatra'

enable :sessions

get '/' do

@files = File.readlines("five_desk.txt")
@pick = @files.select { |w| w.size > 5 && w.size < 12 }.sample
@secret_word = @pick
@secret_word.downcase!
@final_word = @secret_word.gsub(/[a-z]/," _ ")




@final_word = session[:final_word] = @final_word
@session = session[:word] = @secret_word
@@guessesz = session[:guessesz] = 10
  @image = "images/10.jpg"
erb :index
end

get '/output' do
@session = session[:word]
@final_word = session[:final_word]
 #@secret_word = session[:secret_word]
 if  @final_word.all? { |e| e != " _ "  }
   @message = 'Congrats! You guessed the word!'
   @answer = @session.index(params[:guess])
 @final_word[@answer.to_i] = params[:guess]
  @final_word.sub!(/ _ /,'')
   @image = "images/"+@@guessesz.to_s+".jpg"
 erb :result

elsif  @session.include?(params[:guess])

    @message = 'Correct'
    @answer = @session.index(params[:guess])
  @final_word[@answer.to_i] = params[:guess]
   @final_word.sub!(/ _ /,'')

    @image = "images/"+@@guessesz.to_s+".jpg"
  erb :result
elsif @@guessesz == 1
  @message = "GAME OVER! You lost! The word was: #{@session}!"
  @@guessesz = 0
  @image = "images/"+@@guessesz.to_s+".jpg"
  erb :result
else
  @message = 'Incorrect'
  @@guessesz -= 1
  @image = "images/"+@@guessesz.to_s+".jpg"
  erb :result


end

end
