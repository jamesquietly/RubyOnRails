require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

def check_guess(guess)
    message = ""
    if guess > SECRET_NUMBER
        message = "Too high!"
    elsif guess < SECRET_NUMBER
        message = "Too low!"
    else
        message = "You got it right!\nThe SECRET NUMBER is #{SECRET_NUMBER}"
    end
    message
end

get '/' do
    guess = params["guess"].to_i
    message = check_guess(guess)
    erb :index, :locals => {:message => message}
end