require './lib/bitmap'

class BitmapEditor
  class CommandRunner
    def initialize(bitmap_class = Bitmap)
      @bitmap_class = bitmap_class
    end

    def execute(line)
      return unless line =~ /([A-Z])\s?(.*)/
      method = $1.downcase
      args   = $2.split(' ').map{|arg| arg.match(/\d+/) ? arg.to_i : arg }

      if bitmap.respond_to?(method)
        bitmap.send(method, *args)
      else
        puts "unrecognised command :("
      end
    end

    private

    def bitmap
      @bitmap ||= @bitmap_class.new
    end
  end
end
