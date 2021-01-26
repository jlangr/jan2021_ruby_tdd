class Portfolio
  attr_accessor :is_empty

  def initialize
    @is_empty = true
  end

  def empty?
    is_empty
  end

  def purchase
    @is_empty = false
  end
end
