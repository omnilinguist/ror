require 'pry'

def shuffle ary
  if (ary.length < 2)
    return
  end
  (0...ary.length).each { |i|
    j = i + rand(ary.length - i)
    temp = ary[j]
    ary[j] = ary[i]
    ary[i] = temp
  }
  return ary
end

def new_shuffled_deck
  deck = (0...52).reduce([]){ |a,b| a << b}
  return shuffle deck    
end

def deal_initial deck, hands, n
  2.times {
    (0...n).each { |i|
      hands[i] << deck.pop  
    }
  }
end

def print_card card_id
  values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K']
  suits = ['s', 'd', 'h', 'c']
  return values[card_id % 13] + suits[card_id / 13]
end

def print_hand hand
  hand.map{ |c| print_card c }.to_s
end

def count_points hand
  eff_hand = hand.map{ |c| c = c % 13; c = [c, 9].min; c }.sort!.reverse!
  points = 0
  eff_hand.each { |i|
    if i >= 9
      points += 10
    elsif i >= 1
      points += (i + 1)
    elsif i == 0
      points += (points <= 10 ? 11 : 1)
    end
  }
  points
end

def is_blackjack hand
  hand.length == 2 && hand.map{ |c| c = c % 13; c = [c, 9].min; c }.sort == [0, 9]
end

balance = 1000

while true
  puts "Your balance is: " + balance.to_s
  bet = 0
  while bet == 0
    puts "How much to wager (-1 to exit)? "; bet = gets.chomp.to_i
  end
  if bet < 0
    break
  end
  deck = new_shuffled_deck  
  hands = (0...2).reduce([]){ |a,b| a << [] }
  deal_initial deck, hands, 2   # dealer + 1 player
  if (is_blackjack hands[0]) && (is_blackjack hands[1])
    puts "Dealer cards are: " + print_hand(hands[0])
    puts "Your cards are: " + print_hand(hands[1])
    puts "You and dealer both have blackjack and push!"
    next
  end
  if is_blackjack hands[0]
    puts "Dealer cards are: " + print_hand(hands[0])
    puts "Dealer has blackjack!"
    puts "You lost " + (bet * 1.5).to_s + " and now have " + (balance -= bet * 1.5).to_s
    next
  end
  if is_blackjack hands[1]
    puts "Your cards are: " + print_hand(hands[1])
    puts "You have blackjack!"
    puts "You gained " + (bet * 1.5).to_s + " and now have " + (balance += bet * 1.5).to_s
    next
  end
  puts "Dealer face up card is " + print_card(hands[0][0])
  while true
    puts "Your cards are: " + print_hand(hands[1])
    points = count_points hands[1]
    puts "You have #{points} points"
    if points > 21
      puts "You have busted!"
      break
    end
    puts "Action (H)it, (S)tay?"; action = gets.chomp.upcase   #TODO split, doubledown
    case action
      when 'H'
        dealt = deck.pop
        hands[1] << dealt
        puts "You received: " + print_card(dealt)
      when 'S'
        break
      else
        puts "Invalid action!"
    end
  end

  if points > 21
    puts "You lost " + bet.to_s + " and now have " + (balance -= bet).to_s
    next
  end
  puts "Dealer full hand is: " + print_hand(hands[0])
  dpoints = count_points hands[0]
  puts "Dealer has #{dpoints} points"
  while count_points(hands[0]) < 17
    dealt = deck.pop
    hands[0] << dealt
    puts "Dealer hits and gets: " + print_card(dealt)
    puts "Dealer cards are: " + print_hand(hands[0])
    dpoints = count_points hands[0]
    puts "Dealer has #{dpoints} points"
  end
  if dpoints > 21
    puts "Dealer has busted!"
    puts "You gained " + bet.to_s + " and now have " + (balance += bet).to_s
    next
  end
  if dpoints < points
    puts "You win!"
    puts "You gained " + bet.to_s + " and now have " + (balance += bet).to_s
    next
  elsif dpoints == points
    puts "You and the dealer have pushed!"
    next
  elsif dpoints > points
    puts "Dealer wins!"
    puts "You lost " + bet.to_s + " and now have " + (balance -= bet).to_s
    next
  end
end
