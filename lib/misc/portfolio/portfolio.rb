class Portfolio
  attr_accessor :symbol_count

  def initialize
    @symbol_count = 0
  end

  def empty?
    symbol_count.zero?
  end

  def purchase
    @symbol_count += 1
  end
end
