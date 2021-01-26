class NameNormalizer
  attr_reader :name

  def normalize(name)
    return "" if name.blank?
    @name = name

    return first_name if monomym?

    "#{last_name}, #{first_name}"
  end

  private

  def parts
    @parts ||= name.split(' ')
  end

  def first_name
    parts.first
  end

  def middle_initial
    return '' if parts.size == 2

    parts[parts.size - 1].first
  end

  def last_name
    parts.second
  end

  def monomym?
    parts.size == 1
  end
end
