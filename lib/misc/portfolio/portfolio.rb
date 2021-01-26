class Portfolio
  def initialize
    @is_empty = true
  end

  def purchase
    @is_empty = false
  end

  def empty?
    @is_empty
  end
end
