class Portfolio
  def purchase
    @is_empty = false
  end

  def empty?
    @is_empty ||= true
  end
end
