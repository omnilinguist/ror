while true
  input = gets.chomp
  if (input == "BYE")
    break
  end
  if (input.upcase == input)
    puts "NO, NOT SINCE " + (1930 + rand(21)).to_s + "!"
  else
    puts "HUH?! SPEAK UP, SONNY!"
  end
end
