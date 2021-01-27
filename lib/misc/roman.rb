class Roman
  MAPPING = {
    'M' => 1000,
    'CM' => 900,
    'D' => 500,
    'CD' => 400,
    'C' => 100,
    'XC' => 90,
    'L' => 50,
    'XL' => 40,
    'X' => 10,
    'IX' => 9,
    'V' => 5,
    'IV' => 4,
    'I' => 1
  }

  def convert(arabic)
    roman_numeral = ''
    while arabic > 0
      MAPPING.each do |numeral, base|
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
