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
        $remaining_guesses = 6
    end
    $remaining_guesses -= 1
    if $remaining_guesses == 0
        message += " YOU LOST! GENERATING NEW NUMBER!"
        $remaining_guesses = 5
    end
    message += " || Remaining Guesses: #{$remaining_guesses}"
    message
end

def update_guess(number)
    if number == 1
        result = 5
        secret = rand(101)
    else
        result = number - 1
    end
    result
end

get '/' do
    guess = params["guess"].to_i
    message = check_guess(guess)
    erb :index, :locals => {:message => message}
end