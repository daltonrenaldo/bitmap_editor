require './lib/bitmap'

class BitmapEditor
  class CommandParser
    COMMANDS_MAPPING = {
      'C' => :clear,
      'S' => :render_bitmap,
      'I' => :create_bitmap,
      'L' => :color_pixel,
      'V' => :color_column,
      'H' => :color_row
    }

    def parse(line)
      return unless line =~ /([A-Z])\s?(.*)/
      method = COMMANDS_MAPPING[$1]
      args = $2.split(' ').map{|arg| arg.match(/\d+/) ? arg.to_i : arg }
      [method, *args]
    end
  end
end
