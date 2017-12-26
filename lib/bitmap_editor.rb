require './lib/bitmap'
require './lib/bitmap_editor/command_parser'

class BitmapEditor
  attr_reader :bitmap, :command_parser

  def initialize(bitmap = Bitmap.new, command_parser = BitmapEditor::CommandParser.new)
    @bitmap = bitmap
    @command_parser = command_parser
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      perform(*command_parser.parse(line.chomp))
    end
  end

  def perform(command, *args)
    bitmap.send(command, *args) unless bitmap.nil? && command.to_s != "create_bitmap"
  rescue ArgumentError => e
    puts "#{e.message}; skipping command #{command}"
  end
end
