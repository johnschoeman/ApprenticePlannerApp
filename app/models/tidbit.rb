class Tidbit
  attr_reader :title, :url

  def initialize(tidbit_data = {})
    @url = tidbit_data[:url]
    @title = tidbit_data[:title]
  end
end
