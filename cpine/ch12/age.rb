print 'year born? '; yr = gets.to_i
print 'month? '; mo = gets.to_i
print 'day? '; dy = gets.to_i

born = Time.local(yr, mo, dy)
puts 'You will turn 1 billion seconds old on ' + (born + 1000000000).to_s

puts 'You are ' + ((Time.now - born) / 86400 / 365.25).to_i.to_s + ' years old'
