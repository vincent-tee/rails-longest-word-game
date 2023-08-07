require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    dict_url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    url_serialised = URI.open(dict_url).read
    match = JSON.parse(url_serialised)
    word_found = match["found"]

    @outcome = params[:letters].split(' ').sort
    answer = params[:answer].chars.map!(&:upcase)
    @valid_word = false

    @letter_array = []
    answer.each do |letter|
      if @outcome.include?(letter)
        @outcome -= [letter]
        @letter_array << letter
      end
    end
    # checking that there is all the letters and no duplicates is possible in ruby
    # potentially method chaining
    # see array methods

    @match_result = if @letter_array == answer
                      @valid_word = word_found == 'true'
                    else
                      false
                    end
  end
end
