class NameNormalizer
  attr_reader :name

  def normalize(name)
    return "" if name.blank?
    @name = name

    return first_name if monomym?

    "#{last_name}, #{first_name} #{middle_initial}".chomp(' ')
  end

  private

  def parts
    @parts ||= name.split(' ')
  end

  def first_name
    parts.first
  end

  def last_name
    parts.last
  end

  def middle_initial
    return '' if parts.size == 2
    return middle_names.join if middle_names.join.size == 1

    middle_names.map{|name| "#{name.chr}."}.join(' ')
  end

  def middle_names
    parts - [first_name, last_name]
  end

  def monomym?
    parts.size == 1
  end
end
