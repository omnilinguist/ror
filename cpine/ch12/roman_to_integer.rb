def roman_to_integer roman
  result = 0
  vals = {'M' => 1000, 'D' => 500, 'C' => 100, 'L' => 50, 'X' => 10, 'V' => 5, 'I' => 1, 'Z' => 0}
  roman = roman.upcase + 'Z'
  (0...roman.length - 1).each {|i|
    this = vals[roman[i]]
    nextt = vals[roman[i+1]]
    result += (nextt > this ? -1 * this : this)
  }
  result
end
