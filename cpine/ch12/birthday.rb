require 'date'

file = File.read 'birthday.txt'
birthdays = {}

file.each_line { |l|
  idx = l.index(',')
  name = l[0...idx]
  born = l[idx+1..-1].chomp
  birthdays[name] = Date.parse(born)
}

print "who to lookup? "; query = gets.chomp
bday = birthdays[query]
yeardiff = Time.now.year - bday.year
nextage = bday.next_year(yeardiff) > Date.parse(Time.now.to_s) ? yeardiff : yeardiff + 1

puts query + "'s next birthday is on " + bday.next_year(nextage).to_s + " when s/he will be " + nextage.to_s + " years old"
