class Array
  def shuffle
    if (self.length < 2)
      return
    end
    (0...self.length).each { |i|
      j = i + rand(self.length - i)
      temp = self[j]
      self[j] = self[i]
      self[i] = temp
    }
    self
  end
end

class Integer
  def factorial
    factorial_helper self  
  end
  def factorial_helper n
    if (n < 2)
      return 1
    end
    n * factorial_helper(n - 1)
  end
  def to_roman
    letters = ['I', 'X', 'C', 'M']
    fives = {'I' => 'V', 'X' => 'L', 'C' => 'D'}
    vals = [1, 10, 100, 1000]
    result = ""
    prev_letter = ''
    prev_val = vals.last * 15
    n = self
    while ((letter = letters.pop) != nil && ((val = vals.pop) != nil))
      result += get_digit(letter, prev_letter, n / val, fives)
      n = n % val
      prev_letter = letter
      prev_val = val
    end
    result
  end
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
end
