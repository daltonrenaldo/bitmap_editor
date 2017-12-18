class Bitmap
  attr_reader :bitmap

  # creates the bitmap image
  # @param rows [integer] number of rows
  # @param cols [integer] number of columns
  def initialize(rows, cols)
    @bitmap = [["O"] * cols ] * rows
  end

  def to_s
    @bitmap.map do |rows|
      rows.join
    end.join("\n")
  end
end
