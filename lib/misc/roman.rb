class Roman
  def convert(arabic)
    return "V" if arabic > 4
    "I" * arabic
  end
end
