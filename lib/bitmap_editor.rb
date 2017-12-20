require './lib/bitmap'
class BitmapEditor
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
        create_bitmap($1, $2)
      when 'C'
        commandor.clear_bitmap
      when /L\s(\d+)\s(\d+)\s([A-Z])$/
        commandor.color_pixel($1, $2, $3)
      when /V\s(\d+)\s(\d+)\s(\d+)\s([A-Z])$/
        commandor.color_column($1, $2, $3, $4)
      when /H\s(\d+)\s(\d+)\s(\d+)\s([A-Z])$/
        commandor.color_row($1, $2, $3, $4)
      when 'S'
        commandor.render_bitmap
      else
        puts 'unrecognised command :('
      end
    end
  end

  private

  def create_bitmap(rows, cols)
    @bitmap ||= @bitmap_class.new(rows.to_i, cols.to_i)
  end

  def commandor
    @commandor ||= @command_class.new(@bitmap)
  end
end
