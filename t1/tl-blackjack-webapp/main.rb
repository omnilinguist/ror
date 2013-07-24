require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

set :port, 3000

class Player
  attr_accessor :id, :balance, :hand  # Fixnum, Fixnum, Array[Fixnum]
  def initialize id, balance
    @id = id
    @balance = balance
  end 
end

get '/' do
  redirect to(session[:username] ? '/game' : '/register')
end

get '/register' do
  erb :register
end

post '/register' do
  session[:username] = params[:username]
  redirect to('/')
end

get '/game' do
  if !session[:players]
    num_players = 1
    session[:players] = (0...(num_players + 1)).reduce([]){ |a,b| a << Player.new(b, 1000) }
  end
  erb :game
end

post '/game/bet' do
  session[:bet] = params[:bet].to_i
  redirect to('/game/deal_initial')
end

get '/game/deal_initial' do
  session[:deck] = new_shuffled_deck 
  deal_initial session[:deck], session[:players], 2
  redirect to('/game')
end

get '/game/hit' do
  session[:players][1].hand << session[:deck].pop
  if (count_points(session[:players][1].hand) > 21)
    session[:showDealer] = true
    session[:ERROR] = "You have busted!"
    session[:next_page] = "/processResult"
    session[:result] = -1
  end
  redirect to('/game')
end

get '/game/stay' do
  session[:showDealer] = true
  session[:next_page] = "/dealerTurn"
  redirect to('/game')
end

get '/game/dealerTurn' do
  dealer_pts = count_points session[:players][0].hand
  if dealer_pts < 17
    session[:players][0].hand << session[:deck].pop
  end
  dealer_pts = count_points session[:players][0].hand
  player_pts = count_points session[:players][1].hand
  if dealer_pts < 17
    session[:next_page] = "/dealerTurn"
    redirect to('/game')
  elsif dealer_pts > 21 || dealer_pts < player_pts
    session[:SUCCESS] = (dealer_pts > 21) ? "Dealer has busted!" : "You win!"
    session[:next_page] = "/processResult"
    session[:result] = 1
    redirect to('/game')
  elsif dealer_pts > player_pts
    session[:ERROR] = "You lose!"
    session[:next_page] = "/processResult"
    session[:result] = -1
    redirect to('/game')
  else
    session[:INFO] = "You and the dealer push."
    session[:next_page] = "/processResult"
    session[:result] = 0
    redirect to('/game')
  end
end

get '/game/processResult' do
  session[:players][1].balance += session[:result] * session[:bet]
  session.delete(:showDealer)
  session.delete(:result)
  session.delete(:bet)
  session.delete(:next_page)
  redirect to('/game')
end

# testing backdoor
get '/reset' do
  session.clear
  redirect to('/')
end


## HELPERS

helpers do
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

  def get_card_path card_id
    values = ['ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king']
    suits = ['spades', 'diamonds', 'hearts', 'clubs']
    return suits[card_id / 13] + "_" + values[card_id % 13] + ".jpg"
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
end

## NON APPLICATION SPECIFIC

get '/hi' do
  'hi'
end

get '/hello' do
  erb :hello
end

get '/hello/world' do
  erb 'hello/world'.to_sym
end
