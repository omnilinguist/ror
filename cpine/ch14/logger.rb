$depth = 0
def log description, &block
  puts ("  " * $depth) + "Beginning \"#{description}\"..."
  $depth += 1
  result = block.call
  $depth -= 1
  puts ("  " * $depth) + "...\"#{description}\" finished, returning: " + result.to_s
end

log 'outer block' do
  log 'some little block' do
    log 'teeny-tiny block' do
      'lots of love'
    end
    42
  end
  log 'yet another block' do
    'I love Indian food!'
  end
  true
end 
