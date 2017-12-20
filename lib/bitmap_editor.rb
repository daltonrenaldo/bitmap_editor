require './lib/bitmap'
class BitmapEditor
  attr_writer :bitmap

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when /I\s(\d+)\s(\d+)/
        create_bitmap($1, $2)
      when 'C'
        clear_bitmap
      when /L\s(\d+)\s(\d+)\s(.)/
        puts ""
      when 'S'
          show_bitmap
      else
          puts 'unrecognised command :('
      end
    end
  end

  private

  def create_bitmap(rows, cols)
    @bitmap ||= Bitmap.new(rows.to_i, cols.to_i)
  end

  def clear_bitmap
    return if @bitmap.empty?
    @bitmap.clear
  end

  def show_bitmap
    if @bitmap.empty?
      puts "There is no image"
    else
      puts @bitmap
    end
  end
end
