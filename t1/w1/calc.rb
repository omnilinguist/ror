require 'pry'

def say(msg)
  puts "-- #{msg} --"
end

# reverse polish notation, a generalised case of the calculator implementation shown
# use an Array as a stack data structure
stack = []

while true
  say "The stack is currently: " + stack.to_s
  say "Enter a number or operation, or EXIT to quit:"
  token = gets.chomp

  if token.downcase == 'exit'
    break
  elsif ['+', '-', '*', '/'].include? token
    b = stack.pop
    a = stack.pop
    result = case token
      when '+'
        a + b
      when '-'
        a - b
      when '*'
        a * b
      when '/'
        a / b
    end
    puts "The result is " + result.to_s
    stack.push(result) if result
  else
    stack.push(token.to_i) 
  end
end
