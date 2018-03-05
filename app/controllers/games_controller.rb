require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters_array = []
    10.times { @letters_array << "A".upto("Z").to_a.sample(1) }
    @letters = @letters_array.reduce(:+)
  end

  def score
    @word = params[:word]
    @grid = params[:grid].split("")
    user = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    attempt_array = @word.upcase.split("")
    if  attempt_array.all? { |letter| @grid.count(letter) >= attempt_array.count(letter) } && user["found"] == true
      @post = "Congratulations! #{@word.upcase} is a valid English word!"
    elsif user["found"] == true
      @post = "Sorry but #{@word.upcase} can't be built out of #{@grid.join(",")}"
    else
      @post = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    end
  end
end
