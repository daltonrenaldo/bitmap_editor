require './lib/bitmap'
require './lib/bitmap_editor/command_runner'

class BitmapEditor
  attr_reader :bitmap, :command_runner

  def initialize(bitmap = Bitmap.new, command_runner = BitmapEditor::CommandRunner.new)
    @bitmap = bitmap
    @command_runner = command_runner
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      command_runner.execute(line.chomp, bitmap)
    end
  end

  def command_runner
    @command_runner ||= @command_runner_class.new
  end
end
