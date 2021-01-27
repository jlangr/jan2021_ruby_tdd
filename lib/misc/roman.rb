class Roman
  def convert(arabic)
    mapping = {
      'M' => 1000,
      'C' => 100,
      'X' => 10,
      'I' => 1
    }

    roman_numeral = ''
    while arabic > 0
      mapping.each do |numeral, base|
        if arabic >= base
          roman_numeral += numeral
          arabic -= base
          break
        end
      end
    end
    roman_numeral
  end
end
