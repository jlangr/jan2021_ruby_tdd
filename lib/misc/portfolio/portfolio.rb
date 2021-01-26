class Portfolio
  def initialize
    @purchases = Hash.new(0)
  end

  def purchase(symbol, shares)
    @purchases[symbol.to_sym] += shares
  end

  def purchases
    @purchases
  end

  def shares_of(symbol)
    0
  end

  def empty?
    @purchases.empty?
  end

  def symbols
    @purchases.keys.uniq
  end
end
