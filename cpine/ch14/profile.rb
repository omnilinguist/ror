def profile block_description, &block
  profiling_on = true   # toggle by changing this line
  if profiling_on
    start_time = Time.new
    block.call
    duration = Time.new - start_time
    puts "#{block_description}: #{duration} seconds"
  else
    block.call
  end
end

profile 'count to a million' do
  number = 0
  1000000.times do
  number = number + 1
  end
end
