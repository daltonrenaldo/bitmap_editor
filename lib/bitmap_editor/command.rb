require './lib/bitmap'

class BitmapEditor
  class Command
    MAX_BITMAP_SIZE = 250
    MIN_BITMAP_SIZE = 1

    def initialize(bitmap_class = Bitmap)
      @bitmap_class = bitmap_class
    end

    def perform(command, *args)
      send(command, *args) if bitmap || command.to_s == "i" || command.to_s == "create_bitmap"
    rescue ArgumentError => e
      puts "#{e.message}; skipping command #{command}"
    end

    # Creates bitmap
    # @param cols
    # @param rows
    # @return [Bitmap] the newly created bitmap
    #
    def create_bitmap(cols, rows)
      if (rows > MAX_BITMAP_SIZE || rows < MIN_BITMAP_SIZE ||
          cols > MAX_BITMAP_SIZE || cols < MIN_BITMAP_SIZE)
        return puts "Cannot Create Bitmap: Sizes must be between 1 - 250"
      end

      @bitmap = @bitmap_class.new(rows, cols)
    end
    alias :i :create_bitmap

    # Clears the bitmap
    #
    def clear_bitmap
      bitmap.clear
    end
    alias :c :clear_bitmap

    # Colors the bitmap pixel at index (from coordinate) with a given color
    # @param x     [Number] the x coordinate
    # @param y     [Number] the y coordinate
    # @param color [String] the color
    #
    def color_pixel(x, y, color)
      x_index = x.to_i - 1
      y_index = y.to_i - 1
      bitmap.set_pixel_to({x: x_index, y: y_index}, color)
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
      puts bitmap
    end
    alias :s :render_bitmap

    private

    def bitmap
      @bitmap
    end
  end
end
