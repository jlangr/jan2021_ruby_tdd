class Portfolio
  attr_accessor :symbol_count, :stocks

  def initialize
    @symbol_count = 0
    @stocks = Hash.new(0)
  end

  def empty?
    symbol_count.zero?
  end

  def purchase(symbol, shares)
    @symbol_count += 1
    stocks[symbol] += shares
  end

  def shares(symbol)
    stocks[symbol]
  end
end
