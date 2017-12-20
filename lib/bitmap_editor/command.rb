class BitmapEditor
  class Command
    def initialize(bitmap)
      @bitmap = bitmap
    end

    # Clears the bitmap
    #
    def clear_bitmap
      return if @bitmap.nil?
      @bitmap.clear
    end

    # Colors the bitmap pixel at index (from coordinate) with a given color
    # @param x     [Number] the x coordinate
    # @param y     [Number] the y coordinate
    # @param color [String] the color
    #
    def color_pixel(x, y, color)
      x_index = x.to_i - 1
      y_index = y.to_i - 1
      @bitmap.set_pixel_to({x: x_index, y: y_index}, color)
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
    # @param row       [Number] the row Y
    # @param col_start [Number] col X1
    # @param col_end   [Number] col X2
    # @param color     [String] the color
    #
    def color_row(row, col_start, col_end, color)
      (col_start..col_end).each do |x|
        color_pixel(x, row, color)
      end
    end

    # Draws the bitmap
    #
    def render_bitmap
      if @bitmap.nil?
        puts "There is no image"
      else
        puts @bitmap
      end
    end
  end
end
