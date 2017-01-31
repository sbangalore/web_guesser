require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@guesses_left = 5

def check_guess(guess)
  @@guesses_left -= 1
  if @@guesses_left != 0
    if guess > @@secret_number
      "#{guess} is too high."
    elsif guess < @@secret_number
      "#{guess} is too low."
    else
      @@secret_number = rand(100)
      @@guesses_left = 6
      "perfect, #{guess} is correct."
    end
  else
    @@secret_number = rand(100)
    @@guesses_left = 5
    "New game"
  end
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess.to_i)
  erb :index, :locals => {:guesses_left => @@guesses_left, :message => message}
end