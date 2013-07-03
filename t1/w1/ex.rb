ary = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

ary.each do |i|
  puts i
end

puts "====="

ary.each do |i|
  if i > 5
    puts i
  end
end

puts "====="

puts ary.select{ |i| i % 2 == 1 }.to_s

puts "====="

puts ary.push(11).to_s
puts ary.insert(0, 0).to_s

puts "====="

ary.delete(11)
puts ary.to_s
puts ary.push(3).to_s
puts ary.uniq!.to_s

# array will store an ordered list, but hash is unorderd key/value pairs

h = { :a => 1, :b => 2, :c => 3, :d => 4 }
puts h
h = { a: 1, b: 2, c: 3, d: 4 }
puts h
puts h[:b]

puts h.delete_if{ |k,v| v < 3.5 }

h = { a: [1,2,3], b: [4,5,6] }
puts h.to_s
a = [ {a: 1, b: 2}, {a: 3, b: 4} ]
puts a.to_s
