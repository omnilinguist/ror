def shuffle ary
  if (ary.length < 2)
    return
  end
  (0...ary.length).each { |i|
    j = i + rand(ary.length - i)
    # this commented approach doesn't work per http://adrianquark.blogspot.com/2008/09/how-to-shuffle-array-correctly.html
    # caught in tests
    #j = rand(ary.length - 1)
    #if (j >= i)
    #  j += 1
    #end
    temp = ary[j]
    ary[j] = ary[i]
    ary[i] = temp
  }
end

# test
n = 10
counts = (1..n).reduce([]){ |a,b| a << (1..n).reduce([]){ |a,b| a << 0 } }
## 1st level = position
## 2nd level = how many times that position resolved to some number
10000.times.each {
  sample = (1..n).reduce([]){ |a,b| a << b}
  shuffle sample
  #puts sample
  (0..(n-1)).each { |i|
    counts[i][sample[i] - 1] += 1
  }
}
puts counts.to_s
