class ProductionStockService
  def price(_symbol)
    raise "system down"
  end
end

class Portfolio
  attr_accessor :stock_service

  def initialize(stock_service=ProductionStockService.new)
    @holdings = Hash.new
    @stock_service = stock_service
  end

  def value
    @holdings.keys.inject(0) do |total, symbol|
      total + stock_service.price(symbol) * self[symbol]
    end
  end

  def empty?
    size() === 0
  end

  def size
    @holdings.size
  end

  def purchase(symbol, shares)
    @holdings[symbol] = self[symbol] + shares
  end

  def throw_on_excess_sale(symbol, shares)
    raise InvalidSaleError if self[symbol] < shares
  end

  def sell(symbol, shares)
    throw_on_excess_sale(symbol, shares)
    @holdings[symbol] = self[symbol] - shares
    if self[symbol] === 0
      @holdings.delete(symbol)
    end
  end

  def [](symbol)
    @holdings.has_key?(symbol) ? @holdings[symbol] : 0
  end
end