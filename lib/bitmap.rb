require 'forwardable'
class Bitmap
  attr_reader :bitmap, :rows, :cols
  extend Forwardable
  def_delegators :@bitmap, :empty?

  # creates the bitmap image
  # @param rows [Integer] number of rows
  # @param cols [Integer] number of columns
  # @param color [String] initial color of the pixels
  def initialize(rows, cols, color = "O")
    @rows = rows.to_i # ensure it's an integer
    @cols = cols.to_i
    @bitmap = solid_canvas(color)
  end

  # clears the bitmap; sets all pixels to white (O)
  # @return the newly cleared bitmap
  def clear
    @bitmap = solid_canvas('O')
  end

  # sets the given pixel to the given color
  # @param pixel [Hash :x, :y] x and y COORDINATES for the pixel
  # @param color [String] the color to set the pixel to
  def set_pixel_to(pixel, color)
    return unless pixel_exists?(pixel)
    @bitmap[pixel[:y]][pixel[:x]] = color
  end

  def to_s
    @bitmap.map do |rows|
      rows.join
    end.join("\n")
  end

  private

  def solid_canvas(color)
    array = []
    rows.times do |i|
      array << [color] * cols
    end
    array
  end

  def pixel_exists?(pixel)
    pixel[:x] < cols &&
    pixel[:x] >= 0 &&
    pixel[:y] >= 0 &&
    pixel[:y] < rows
  end
end
