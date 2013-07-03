def ask question
  while true
    puts question
    reply = gets.chomp.downcase
    if (reply != 'yes' && reply != 'no')
      puts 'Please answer "yes" or "no".'
    else
      break
    end
  end
  reply == 'yes'
end

ask 'answer me yes or no'
