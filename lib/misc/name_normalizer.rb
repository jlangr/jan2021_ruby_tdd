class NameNormalizer
  def normalize(name)
    name.split(' ').reverse.join(', ')
  end

  private

  def parts
    @parts ||= name.split(' ')
  end

  def first_name
    @parts.first
  end

  def last_name
    @parts.second
  end
end
