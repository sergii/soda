#!/usr/bin/ruby
require 'sqlite3'

# Open a SQLite 3 database file
def initiate_database
  @db ||= SQLite3::Database.new('api_v1.db') # or ':memory:'
end

begin
  initiate_database
rescue SQLite3::Exception => e
  puts "Exception occurred: #{e}"
end

# Create a table
@db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS words (
    word VARCHAR(30),
    appearance INT
  );
SQL

# Find all word appearances records
def appearances
  @db.execute('SELECT * FROM words')
end

# Find by word. Return first
def find_appearance_by(word)
  query = 'SELECT appearance FROM words WHERE word = ?;'
  @db.get_first_value(query, word)
end

# Create new record
def create(record)
  # @db.execute('insert into words values (?, ?)', appearance)
  @db.execute('INSERT INTO words (word, appearance) VALUES (?, ?)', record[0], record[1])
end

# Update existing record
def update(record)
  query = 'UPDATE words SET appearance=? WHERE word = ?;'
  @db.execute(query, record[1], record[0])
end

def increment_appearance_counter_for(word)
  number_of_appearances = find_appearance_by(word)
  record = [] << word <<  number_of_appearances += 1
  update(record)
end

def initiate_appearance_counter_for(word)
  record = [] << word << 1
  create(record)
end

puts 'Please, enter the sentences:'
input = gets.chomp
words = input.split(/\W+/) # extracting words from the input string

# Iterate over all words
words.each do |word|
  unless find_appearance_by(word)
    # Since the word appeared for the first time, set number of appearances to 1
    puts "Create appearance of word: #{word}"
    initiate_appearance_counter_for(word)
  else
    # Since the word already appeared, increment number of word appearances by 1
    puts "  Increment appearance of word: #{word}"
    increment_appearance_counter_for(word)
  end
end

puts
puts "Number of appearances of each word: #{appearances}"
