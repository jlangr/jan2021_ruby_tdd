class Roman
  NUMERALS = [
    [1000, 'M'],
    [900, 'CM'],
    [500, 'D'],
    [400,'CD'],
    [100, 'C'],
    [90, 'XC'],
    [50, 'L'],
    [40, 'XL'],
    [10, 'X'],
    [5, 'V'],
    [4,'IV'],
    [1, 'I']
  ]

  def convert(value)
    roman = ''
    NUMERALS.each do |arabic, roman_symbol|
      # value = 4
      #
      while value >= arabic do
        roman += roman_symbol
        value -= arabic
      end
    end
    roman
  end
end
