n = 3
while true
  input = gets.chomp
  if (input == "BYE")
    n = n - 1
    if (n == 0)
      break
    end
  else
    n = 3
  end
  if (input.upcase == input)
    puts "NO, NOT SINCE " + (1930 + rand(21)).to_s + "!"
  else
    puts "HUH?! SPEAK UP, SONNY!"
  end
end
