puts "enter some words:"
lines = []
while (line = gets.chomp).length > 0
  lines.push(line)
end
puts lines.sort
