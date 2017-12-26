require 'forwardable'
class Bitmap
  attr_reader :bitmap, :rows, :cols
  extend Forwardable
  def_delegators :@bitmap, :empty?

  MAX_BITMAP_SIZE = 250
  MIN_BITMAP_SIZE = 1

  # Creates bitmap
  # @param cols
  # @param rows
  # @return [Bitmap] the newly created bitmap
  #
  def create_bitmap(cols, rows, color = "O")
    if (rows > MAX_BITMAP_SIZE || rows < MIN_BITMAP_SIZE ||
        cols > MAX_BITMAP_SIZE || cols < MIN_BITMAP_SIZE)
      return puts "Cannot Create Bitmap: Sizes must be between 1 - 250"
    end

    @rows = rows
    @cols = cols
    @bitmap = solid_canvas(color)
  end
  alias :i :create_bitmap

  # clears the bitmap; sets all pixels to white (O)
  # @return the newly cleared bitmap
  def clear
    @bitmap = solid_canvas('O')
  end
  alias :c :clear

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

  # Colors the bitmap pixel at index (from coordinate) with a given color
  # @param x     [Number] the x coordinate
  # @param y     [Number] the y coordinate
  # @param color [String] the color
  #
  def color_pixel(x, y, color)
    x_index = x.to_i - 1
    y_index = y.to_i - 1
    set_pixel_to({x: x_index, y: y_index}, color)
  end
  alias :l :color_pixel

  # Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)
  # @param col       [Number] the column X
  # @param row_start [Number] row Y1
  # @param row_end   [Number] row Y2
  # @param color     [String] the color
  #
  def color_column(col, row_start, row_end, color)
    (row_start..row_end).each do |y|
      color_pixel(col, y, color)
    end
  end
  alias :v :color_column

  # Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive)
  # @param col_start [Number] col X1
  # @param col_end   [Number] col X2
  # @param row       [Number] the row Y
  # @param color     [String] the color
  #
  def color_row(col_start, col_end, row, color)
    (col_start..col_end).each do |x|
      color_pixel(x, row, color)
    end
  end
  alias :h :color_row

  # Draws the bitmap
  #
  def render_bitmap
    puts self
  end
  alias :s :render_bitmap

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
