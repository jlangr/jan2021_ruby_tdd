CONVERSIONS = [
  { :arabic_digit => 100, :roman_digit => "C" },
  { :arabic_digit => 10, :roman_digit => "X" },
  { :arabic_digit => 1, :roman_digit => "I" }
]

def convert(arabic)
  CONVERSIONS.reduce("") do |roman, conversion|
    digits_needed = arabic / conversion[:arabic_digit]
    arabic -= conversion[:arabic_digit] * digits_needed
    return roman + conversion[:roman_digit] * digits_needed
  end
end