class RecentFileList
  attr_reader :filenames

  def initialize
    @filenames = []
  end

  def open(filename)
    if @filenames.include? filename
      @filenames.insert(0, @filenames.delete(filename))
    else
      @filenames.insert(0, filename)
    end
  end
end