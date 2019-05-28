require './db_manager'
require './models'

puts @db = DbManager.new('book1')
puts 'Database created successfully'
puts 'Use @db for further set up'
