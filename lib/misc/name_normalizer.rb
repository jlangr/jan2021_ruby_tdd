class NameNormalizer
  def normalize(name)
    names = name.split(" ")

    return name if names.size < 2
    return "#{names.last}, #{names.first}" if names.size == 2

    middle_initial = names.second.first

    if names.second.length == 1
      "#{names.last}, #{names.first} #{middle_initial}"
    else
      "#{names.last}, #{names.first} #{middle_initial}."
    end
  end
end
