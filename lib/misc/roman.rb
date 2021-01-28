class Roman
  CONVERSIONS = [
    { :arabic_digit => 1000, :roman_digit => "M" },
    { :arabic_digit => 900, :roman_digit => "CM" },
    { :arabic_digit => 500, :roman_digit => "D" },
    { :arabic_digit => 400, :roman_digit => "CD" },
    { :arabic_digit => 100, :roman_digit => "C" },
    { :arabic_digit => 90, :roman_digit => "XC" },
    { :arabic_digit => 50, :roman_digit => "L" },
    { :arabic_digit => 40, :roman_digit => "XL" },
    { :arabic_digit => 10, :roman_digit => "X" },
    { :arabic_digit => 9, :roman_digit => "IX" },
    { :arabic_digit => 5, :roman_digit => "V" },
    { :arabic_digit => 4, :roman_digit => "IV" },
    { :arabic_digit => 1, :roman_digit => "I" }
  ]

  def self.convert(arabic)
    CONVERSIONS.reduce("") do |roman, conversion|
      digits_needed = (arabic / conversion[:arabic_digit])
      arabic -= conversion[:arabic_digit] * digits_needed
      roman + conversion[:roman_digit] * digits_needed
    end
  end
end
