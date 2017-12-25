require './lib/bitmap_editor/command_runner'

class BitmapEditor
  MAX_BITMAP_SIZE = 250
  MIN_BITMAP_SIZE = 1

  def initialize(command_runner_class = BitmapEditor::CommandRunner)
    @command_runner_class = command_runner_class
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      command_runner.execute(line.chomp)
    end
  end

  def command_runner
    @command_runner ||= @command_runner_class.new
  end
end
