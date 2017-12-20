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
      @bitmap.set_pixel_to({x: x.to_i, y: y.to_i}, color)
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
