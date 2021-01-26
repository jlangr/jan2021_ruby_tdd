class NameNormalizer

  def normalize(name)
    return "" if name.empty?
    parse(name)
    return name if mononym?
    return format_duonym if duonym?
    return format_western_name
  end

  private

  def format_western_name
    "#{last}, #{first} #{middle_initials}#{suffix}"
  end

  def suffix
    ",#{@suffix}" unless @suffix.blank?
  end

  def format_duonym
    "#{last}, #{first}"
  end

  def duonym?
    @parts.length === 2
  end

  def initial(name_part)
    name_part.length === 1 ? name_part : "#{name_part[0]}."
  end

  def middle_initial
    initial(@parts[1])
  end

  def middle_initials
    @parts.slice(1..-2)
      .map { | name | initial(name) }
      .join(" ")
  end

  def raise_on_excess_commas(name)
    raise ArgumentError if name.count(",") > 1
  end

  def parse(name)
    raise_on_excess_commas(name)
    base_name, @suffix = name.split(",")
    @parts = base_name.split(" ")
  end

  def first
    @parts.first
  end

  def last
    @parts.last
  end

  def mononym?
    @parts.length <= 1
  end
end