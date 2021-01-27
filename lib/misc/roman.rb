class Roman
  NUMERALS = [[1, 'I'], [5, 'V']]
  def convert(arabic)
    return "V" if arabic > 4
    NUMERALS.each do |num, roman_symbol|
    end
    "I" * arabic
  end
end
