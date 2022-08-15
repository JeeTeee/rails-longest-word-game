require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.shuffle[0..9]
  end

  def score
    word = params[:word]
    grid = params[:grid]
    @display = "Congratulation! #{word} is a valid english word !" if english_word?(word)
    @display = "Sorry! #{word} isn't a valid english word :(" unless english_word?(word)
    @display = "Sorry! #{word} can't be built in #{grid} :(" unless grid_word?(word, grid)
    @display = "C'est la fête !!!!!!!!!" if english_word?(word) && grid_word?(word, grid)
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def grid_word?(word, grid)
    word.chars.all? { |letter| grid.include?(letter.upcase) }
  end
end
