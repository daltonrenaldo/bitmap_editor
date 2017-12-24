require './lib/bitmap'
require './lib/bitmap_editor/command'

class BitmapEditor
  MAX_BITMAP_SIZE = 250
  MIN_BITMAP_SIZE = 1

  def initialize(bitmap_class = Bitmap, command_class = BitmapEditor::Command)
    @bitmap_class = bitmap_class
    @command_class = command_class
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when /I\s(\d+)\s(\d+)/
        create_bitmap($2.to_i, $1.to_i)
      when 'C'
        commandor.perform(:clear_bitmap)
      when /L\s(\d+)\s(\d+)\s([A-Z])$/
        commandor.perform(:color_pixel, $1, $2, $3)
      when /V\s(\d+)\s(\d+)\s(\d+)\s([A-Z])$/
        commandor.perform(:color_column, $1, $2, $3, $4)
      when /H\s(\d+)\s(\d+)\s(\d+)\s([A-Z])$/
        commandor.perform(:color_row, $3, $1, $2, $4)
      when 'S'
        commandor.perform(:render_bitmap)
      else
        puts 'unrecognised command :('
      end
    end
  end

  private

  def create_bitmap(rows, cols)
    if (rows > MAX_BITMAP_SIZE || rows < MIN_BITMAP_SIZE ||
        cols > MAX_BITMAP_SIZE || cols < MIN_BITMAP_SIZE)
      return puts "Cannot Create Bitmap: Sizes must be between 1 - 250"
    end

    @bitmap ||= @bitmap_class.new(rows, cols)
  end

  def commandor
    @commandor ||= @command_class.new(@bitmap)
  end
end
