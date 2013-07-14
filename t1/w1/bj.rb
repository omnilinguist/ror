require 'pry'

# Implementation of https://en.wikipedia.org/wiki/Blackjack

class Player
  attr_accessor :id, :balance, :hand
  def initialize id, balance
    @id = id
    @balance = balance
  end
end

def new_shuffled_deck
  deck = (0...52).reduce([]){ |a,b| a << b}
  return deck.shuffle
end

def deal_initial deck, players, n
  (0...n).each do |i|
    players[i].hand = []
  end
  2.times do
    (0...n).each do |i|
      players[i].hand << deck.pop
    end
  end
end

def print_card card_id
  values = ['A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K']
  suits = ['s', 'd', 'h', 'c']
  return values[card_id % 13] + suits[card_id / 13]
end

def print_hand hand
  hand.map{ |c| print_card c }.to_s
end

def print_hand_verbose player
  puts (player.id == 0 ? "Dealer" : "Player " + player.id.to_s) + " cards are: " + (print_hand player.hand)
end

def count_points hand
  points = 0
  eff_hand = hand.map{ |c| c = c % 13; c = [c, 9].min; c }.sort!.reverse!
  eff_hand.each { |i|
    if i >= 1
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

def new_balance_verbose balance, bet, factor
  balance += bet * factor   # pass by reference does not modify caller's value
  puts "You " + (factor > 0 ? "gained" : "lost") + " " + (bet * factor).abs.to_s + " and now have " + balance.to_s
  balance
end

num_players = 1
players = (0...(num_players + 1)).reduce([]){ |a,b| a << Player.new(b, 1000) }
# dealer = players[0], but balance is meaningless for dealer
# TODO enable multiple players
while true
  puts "Your balance is: " + players[1].balance.to_s
  bet = 0
  while bet == 0
    puts "How much to wager (-1 to exit)? "; bet = gets.chomp.to_i
  end
  if bet < 0
    break
  end
  deck = new_shuffled_deck
  deal_initial deck, players, 2   # dealer + 1 player
  if (is_blackjack players[0].hand) && (is_blackjack players[1].hand)
    print_hand_verbose players[0]
    print_hand_verbose players[1]
    puts "You and dealer both have blackjack and push!"
    next
  end
  if is_blackjack players[0].hand
    print_hand_verbose players[0]
    puts "Dealer has blackjack!"
    players[1].balance = new_balance_verbose players[1].balance, bet, -1.5
    next
  end
  if is_blackjack players[1].hand
    print_hand_verbose players[1]
    players[1].balance = new_balance_verbose players[1].balance, bet, 1.5
    next
  end
  puts "Dealer face up card is " + print_card(players[0].hand[0])
  while true
    print_hand_verbose players[1]
    points = count_points players[1].hand
    puts "You have #{points} points"
    if points > 21
      puts "You have busted!"
      break
    end
    puts "Action (H)it, (S)tay?"; action = gets.chomp.upcase   #TODO split, doubledown
    case action
      when 'H'
        dealt = deck.pop
        players[1].hand << dealt
        puts "You received: " + print_card(dealt)
      when 'S'
        break
      else
        puts "Invalid action!"
    end
  end

  if points > 21
    players[1].balance = new_balance_verbose players[1].balance, bet, -1
    next
  end
  print_hand_verbose players[0]
  dpoints = count_points players[0].hand
  puts "Dealer has #{dpoints} points"
  while count_points(players[0].hand) < 17
    dealt = deck.pop
    players[0].hand << dealt
    puts "Dealer hits and gets: " + print_card(dealt)
    print_hand_verbose players[0]
    dpoints = count_points players[0].hand
    puts "Dealer has #{dpoints} points"
  end
  if dpoints > 21
    puts "Dealer has busted!"
    players[1].balance = new_balance_verbose players[1].balance, bet, 1
    next
  end
  if dpoints < points
    puts "You win!"
    players[1].balance = new_balance_verbose players[1].balance, bet, 1
    next
  elsif dpoints == points
    puts "You and the dealer have pushed!"
    next
  elsif dpoints > points
    puts "Dealer wins!"
    players[1].balance = new_balance_verbose players[1].balance, bet, -1
    next
  end
end
