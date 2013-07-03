load 'english_number.rb'

puts "how many bottles?"; n = gets.to_i

while n > 0
  puts english_number(n) + " bottles of beer on the wall, " + english_number(n) + " bottles of beer."
  puts "Take one down, pass it around, " + english_number(n = n - 1) + " bottles of beer on the wall."
end
