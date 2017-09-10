require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

def check_guess(guess)
    message = ""
    if guess > SECRET_NUMBER
        if guess > SECRET_NUMBER + 5
            message = "Way too high!"
        else
            message = "Too high!"
        end
    elsif guess < SECRET_NUMBER
        if guess < SECRET_NUMBER - 5
            message = "Way too low!"
        else
            message = "Too low!"
        end
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