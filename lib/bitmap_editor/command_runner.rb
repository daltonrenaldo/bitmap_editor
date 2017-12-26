require './lib/bitmap'

class BitmapEditor
  class CommandRunner
    COMMANDS_MAPPING = {
      'C' => :clear,
      'S' => :render_bitmap,
      'I' => :create_bitmap,
      'L' => :color_pixel,
      'V' => :color_column,
      'H' => :color_row
    }

    def execute(line, bitmap)
      return unless line =~ /([A-Z])\s?(.*)/
      method = COMMANDS_MAPPING[$1]
      return puts 'unrecognised command :(' unless method && bitmap.respond_to?(method)
      args = $2.split(' ').map{|arg| arg.match(/\d+/) ? arg.to_i : arg }
      bitmap.send(method, *args)
    end
  end
end
