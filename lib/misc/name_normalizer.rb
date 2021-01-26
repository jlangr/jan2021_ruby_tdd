class NameNormalizer
  attr_reader :name

  def normalize(name)
    @name = name
    comma_count = name.count(',')

    raise ArgumentError if comma_count > 1

    return '' if name.blank?
    return name if names.size < 2
    return "#{names.last}, #{names.first}" if names.size == 2

    middle_initial = names.second.first


    return "#{names.last}, #{names.first} #{middle_initial}" if names.second.length == 1


    name = "#{names.last}, #{names.first} #{middle_names(names)}#{title}"
  end

  def name_parts
    name.split(',')[0]
  end

  def title
    return unless name.include?(',')
    title = name.split(',').last
    return '' unless title

    ",#{title}"
  end

  def names
    name_parts.split(" ")
  end

  def middle_names(names)
    names.slice(1..-2).map! {|p| "#{p.first}."}.join(' ')
  end
end
