print "start year? "; first = gets.to_i
print "end year? "; last = gets.to_i
cur = first
while cur <= last
  if (cur % 4 == 0) && (cur % 100 != 0 || cur % 400 == 0)
    puts cur
  end
  cur = cur + 1
end
