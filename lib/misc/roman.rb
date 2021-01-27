class Roman
  NUMERALS = [
    [1000, 'M'],
    [500, 'D'],
    [400,'CD'],
    [100, 'C'],
    [10, 'X'],
    [5, 'V'],
    [4,'IV'],
    [1, 'I']
  ]

  def convert(value)
    roman = ''
    NUMERALS.each do |arabic, roman_symbol|
      while value >= arabic do
        roman += roman_symbol
        value -= arabic
      end
    end
    roman
  end
end
