require 'forwardable'
class Bitmap
  attr_reader :bitmap, :rows, :cols
  extend Forwardable
  def_delegators :@bitmap, :nil?

  MAX_BITMAP_SIZE = 250
  MIN_BITMAP_SIZE = 1
  DEFAULT_COLOR   = "O"

  # Creates bitmap
  # @param cols
  # @param rows
  # @return [Bitmap] the newly created bitmap
  #
  def create_bitmap(cols, rows, color = DEFAULT_COLOR)
    if (rows > MAX_BITMAP_SIZE || rows < MIN_BITMAP_SIZE ||
        cols > MAX_BITMAP_SIZE || cols < MIN_BITMAP_SIZE)
      return puts "Cannot Create Bitmap: Sizes must be between 1 - 250"
    end

    @rows = rows
    @cols = cols
    @bitmap = solid_canvas(color)
  end

  # clears the bitmap; sets all pixels to white (O)
  # @return the newly cleared bitmap
  def clear
    @bitmap = solid_canvas(DEFAULT_COLOR)
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
    return unless pixel_exists?(x, y)
    bitmap[y.to_i - 1][x.to_i - 1] = color
  end

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

  # Fills adjacent pixel of the same color recursively
  def flood_fill(x, y, color)
    x_i, y_i = pixel_to_index(x, y)
    original_color = bitmap[y_i][x_i]
    flood_fill_helper(x, y, original_color, color)
  end

  # Draws the bitmap
  #
  def render_bitmap
    puts self
  end

  private

  def flood_fill_helper(x, y, original_color, color, stack =[])
    return unless pixel_exists?(x, y)
    stack.push({x: x, y: y}) # convert to index
    pixel = stack.pop
    return unless original_color == pixel_color(x, y)
    color_pixel(pixel[:x], pixel[:y], color)

    flood_fill_helper(x - 1, y, original_color, color, stack)
    flood_fill_helper(x + 1, y, original_color, color, stack)
    flood_fill_helper(x, y - 1, original_color, color, stack)
    flood_fill_helper(x, y + 1, original_color, color, stack)
  end

  def pixel_to_index(x, y)
    x_index = x.to_i - 1
    y_index = y.to_i - 1
    [x_index, y_index]
  end

  def pixel_color(x, y)
    if pixel_exists?(x, y)
      bitmap[y - 1][x - 1]
    end
  end

  def solid_canvas(color)
    array = []
    rows.times do |i|
      array << [color] * cols
    end
    array
  end

  def pixel_exists?(x, y)
    x_index = x.to_i - 1
    y_index = y.to_i - 1

    x_index < cols &&
    x_index >= 0 &&
    y_index >= 0 &&
    y_index < rows
  end
end
