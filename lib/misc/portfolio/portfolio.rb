class Portfolio
  attr_reader :purchases

  def initialize
    @purchases = Hash.new(0)
  end

  def purchase(symbol, shares)
    @purchases[symbol] += shares
  end

  def shares_of(symbol)
    @purchases[symbol.to_sym]
  end

  def sell(symbol, shares)
    @purchases[symbol.to_sym] -= shares
  end

  def empty?
    @purchases.empty?
  end

  def symbols
    @purchases.keys.uniq
  end
end
