class Portfolio
  def initialize
    @symbols = []
  end

  def purchase(symbol)
    @symbols << symbol
  end

  def empty?
    @symbols.empty?
  end

  def symbols
    @symbols
  end
end
