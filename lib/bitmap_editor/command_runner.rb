require './lib/bitmap_editor/command'

class BitmapEditor
  class CommandRunner
    def initialize(command_class = BitmapEditor::Command)
      @command_class = command_class
    end

    def execute(line)
      return unless line =~ /([A-Z])\s?(.*)/
      method = $1.downcase
      args   = $2.split(' ').map{|arg| arg.match(/\d+/) ? arg.to_i : arg }

      if commandor.respond_to?(method)
        commandor.perform(method, *args)
      else
        puts 'unrecognised command :('
      end
    end

    private

    def commandor
      @commandor ||= @command_class.new
    end
  end
end
