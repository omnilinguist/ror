def chime &block
  h = Time.new.hour % 12
  if h == 0
    h = 12
  end
  h.times {
    block.call
  }
end

chime do
  puts 'DONG'
end
