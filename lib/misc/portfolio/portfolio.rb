class Portfolio
  def initialize
    @is_empty = true
  end

  def purchase(symbol)
    @is_empty = false
    @symbols = symbol
  end

  def empty?
    @is_empty
  end

  def symbols
    @symbols
  end
end
