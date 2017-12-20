class BitmapEditor
  class Command
    def initialize(bitmap)
      @bitmap = bitmap
    end

    def clear_bitmap
      return if @bitmap.nil?
      @bitmap.clear
    end

    def color_pixel(x, y, color)
      x_index = x.to_i - 1
      y_index = y.to_i - 1
      @bitmap.set_pixel_to({x: x_index, y: y_index}, color)
    end

    def color_column(col, row_start, row_end, color)
      (row_start..row_end).each do |y|
        color_pixel(col, y, color)
      end
    end

    def color_row(row, col_start, col_end, color)
      (col_start..col_end).each do |x|
        color_pixel(x, row, color)
      end
    end

    def render_bitmap
      if @bitmap.nil?
        puts "There is no image"
      else
        puts @bitmap
      end
    end
  end
end
