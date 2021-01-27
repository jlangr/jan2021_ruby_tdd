class Roman
  NUMERALS = [
    [100, 'C'],
    [10, 'X'],
    [5, 'V'],
    [4,'IV'],
    [1, 'I']
  ]

  def convert(arabic)
    roman = ''
    NUMERALS.each do |num, roman_symbol|
      while arabic >= num do
        roman += roman_symbol
        arabic -= num
      end
    end
    roman
  end
end
