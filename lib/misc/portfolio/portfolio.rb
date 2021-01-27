class Portfolio
  attr_accessor :stocks

  def initialize
    @stocks = Hash.new(0)
  end

  def empty?
    symbol_count.zero?
  end

  def purchase(symbol, shares)
    stocks[symbol] += shares
  end

  def sell(symbol, shares)
    raise ArgumentError if stocks[symbol] < shares

    stocks[symbol] -= shares
  end

  def symbol_count
    stocks.keys.count
  end

  def shares(symbol)
    stocks[symbol]
  end
end
