require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10).join
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = open(url, &:read)
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def letter_in_grid
    @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each_char { |letter| print letter, ''}
    if !letter_in_grid
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{grid_letters}."
    elsif !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_grid && !english_word
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    elsif letter_in_grid && english_word
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    end
  end
end
