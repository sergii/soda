#!/usr/bin/ruby

# input = gets.chomp # If we want to parse input from STDIN in the future
input = 'Hi! My name is (what?), my name is (who?), my name is Slim Shady'
words = input.split(/\W+/) # extracting words from the input string

# We can imagine appearances like a Hash.
#
# appearances = {
#   input_word1: number_of_appearances_input_word1,
#   input_word2: number_of_appearances_input_word2,
#   input_word3: number_of_appearances_input_word3
# }
#
# For example:
#
# appearances = {
#   Hi: 1,
#   what: 1,
#   name: 2
# }

appearances = {}
number_of_appearances = 0

# Iterate over all words
words.each do |word|
  if appearances[word.to_sym]
    # Since the word already appeared, increment number of word appearances by 1
    appearances.merge!({ "#{word}": number_of_appearances += 1 })
  else
    # Since the word appeared for the first time, set number of appearances to 1
    appearances.merge!({ "#{word}": number_of_appearances = 1 })
    number_of_appearances = 0 # clear the counter
  end
end

puts "Input string: #{input}"
puts "Number of appearances of each word: #{appearances}"
