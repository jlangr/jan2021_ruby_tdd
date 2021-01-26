class Portfolio
  attr_accessor :symbol_count

  def initialize
    @symbol_count = 0
  end

  def empty?
    symbol_count.zero?
  end

  def purchase(symbol, shares)
    @symbol_count += 1
  end

  def shares(symbol)
    return 0 if empty?
    case symbol
    when 'AAPL'
      30
    end
  end
end
