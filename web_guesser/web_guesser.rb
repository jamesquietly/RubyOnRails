require 'sinatra'
require 'sinatra/reloader'

$secret = rand(101)
$remaining_guesses = 5
def check_guess(guess)
    message = ""
    if guess > $secret
        if guess > $secret + 5
            message = "Way too high!"
        else
            message = "Too high!"
        end
    elsif guess < $secret
        if guess < $secret - 5
            message = "Way too low!"
        else
            message = "Too low!"
        end
    else
        message = "You got it right!\nThe SECRET NUMBER is #{$secret}, GENERATING NEW NUMBER!"
        $secret = rand(101)
        $remaining_guesses = 6
    end
    $remaining_guesses -= 1
    if $remaining_guesses == 0
        message += " YOU LOST! GENERATING NEW NUMBER!"
        $secret = rand(101)
        $remaining_guesses = 5
    end
    message += " || Remaining Guesses: #{$remaining_guesses}"
    message
end

def check_cheat(string)
    result = ""
    if string == "true"
        result = "The SECRET NUMBER is #{$secret}"
    end
    result
end

get '/' do
    guess = params["guess"].to_i
    message = check_guess(guess)
    other_message = check_cheat(params["cheat"])
    erb :index, :locals => {:message => message,
                            :other_message => other_message}
end