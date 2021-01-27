class Roman
  NUMERALS = [[5, 'V'], [1, 'I']]
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
