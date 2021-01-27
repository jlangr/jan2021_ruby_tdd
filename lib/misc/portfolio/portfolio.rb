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
    raise_if_too_many_shares

    @purchases[symbol] -= shares
  end

  def empty?
    @purchases.empty?
  end

  def symbols
    @purchases.select {|_k,v| v > 0 }.keys
  end

  private

  def raise_if_too_many_shares
    raise StandardError if shares > @purchases[symbol]
  end
end
