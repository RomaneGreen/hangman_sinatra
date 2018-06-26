
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

@session = session[:number] = rand(10)



erb :index
end

get '/outplause' do
@session = session[:number]
if params[:guess].to_i == session[:number].to_i
  @message = 'Yes'
  erb :come
else
  @message = 'No'
  erb :come

end
# erb :come


end
