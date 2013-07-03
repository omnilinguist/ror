def old_roman_numeral n
  letters = ['I', 'V', 'X', 'L', 'C', 'D', 'M']
  vals = [1, 5, 10, 50, 100, 500, 1000]
  result = ""
  while ((letter = letters.pop) != nil && ((val = vals.pop) != nil))
    result += letter * (n / val)
    n = n % val
  end
  result
end 

# this is rather annoying to generalise
def get_digit(one, ten, times, fives)
  if (times == 9)
    return one + ten
  elsif (times >= 5)
    return fives[one] + one * (times - 5)
  elsif (times == 4)
    return one + fives[one]
  else
    return one * times
  end
end

def roman_numeral n
  letters = ['I', 'X', 'C', 'M']
  fives = {'I' => 'V', 'X' => 'L', 'C' => 'D'}
  vals = [1, 10, 100, 1000]
  result = ""
  prev_letter = ''
  prev_val = vals.last * 15
  while ((letter = letters.pop) != nil && ((val = vals.pop) != nil))
    result += get_digit(letter, prev_letter, n / val, fives)
    n = n % val
    prev_letter = letter
    prev_val = val
  end
  result
end
