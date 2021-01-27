class Portfolio
  attr_reader :purchases

  def initialize
    @purchases = Hash.new(0)
  end

  def purchase(symbol, shares)
    @purchases[symbol] += shares
  end

  def shares_of(symbol)
    @purchases[symbol]
  end

  def sell(symbol, shares)
    @purchases[symbol] -= shares
  end

  def empty?
    @purchases.empty?
  end

  def symbols
    @purchases.count {|k,v| v > 0 }
  end
end
