puts "how many bottles?"; n = gets.to_i

while n > 0
  puts n.to_s + " bottles of beer on the wall, " + n.to_s + " bottles of beer."
  puts "Take one down, pass it around, " + (n = n - 1).to_s + " bottles of beer on the wall."
end
