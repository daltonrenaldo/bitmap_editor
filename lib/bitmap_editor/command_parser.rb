require './lib/bitmap'

class BitmapEditor
  class CommandParser
    class UnknownCommandError < StandardError; end

    COMMANDS_MAPPING = {
      'C' => :clear,
      'S' => :render_bitmap,
      'I' => :create_bitmap,
      'L' => :color_pixel,
      'V' => :color_column,
      'H' => :color_row,
      'F' => :flood_fill
    }

    def parse(line)
      if line =~ /([A-Z])\s?(.*)/
        method = COMMANDS_MAPPING[$1]
        if method
          args = $2.split(' ').map{|arg| arg.match(/\d+/) ? arg.to_i : arg }
          return [method, *args]
        end
      end

      raise UnknownCommandError.new("unrecognised command '#{$1}'")
    end
  end
end
