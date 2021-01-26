class Portfolio
  def initialize
    @purchases = {}
  end

  def purchase(symbol, shares)
    @purchases[symbol.to_sym] = shares
  end

  def purchases
    @purchases
  end

  def empty?
    @purchases.empty?
  end

  def symbols
    @purchases.keys.uniq
  end
end
