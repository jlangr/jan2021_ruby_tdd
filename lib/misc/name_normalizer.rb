class NameNormalizer
  attr_reader :name

  def normalize(name)
    return "" if name.blank?

    @name = name
    first_name
  end

  private

  def parts
    @parts ||= name.split(' ')
  end

  def first_name
    parts.first
  end

  def last_name
    parts.second
  end

  def monomym?
    parts.size == 1
  end
end
