require 'spec_helper'
require './lib/bitmap_editor/command'

describe BitmapEditor::Command do
  let(:command) { described_class.new(bitmap) }
  let(:bitmap) { double('bitmap') }

  describe '#render_bitmap' do
    it "renders the bitmap" do
      expect(STDOUT).to receive(:puts).with(bitmap)
      command.render_bitmap
    end

    context 'when bitmap is not present' do
      let(:bitmap) { nil }

      it "says 'There is no image'" do
        expect(STDOUT).to receive(:puts).with("There is no image")
        command.render_bitmap
      end
    end
  end

  describe '#clear_bitmap' do
    it "clears the bitmap" do
      expect(bitmap).to receive(:clear)
      command.clear_bitmap
    end
  end

  describe '#color_pixel' do
    it "colors the given pixel coordinate of the bitmap" do
      expect(bitmap).to receive(:set_pixel_to).with({x: 1, y: 3}, 'B')
      command.color_pixel('2', '4', 'B')
    end
  end

  describe '#color_column' do
    it "colors column 2 from row 1 to row 3" do
      expect(command).to receive(:color_pixel).with('2', '1', 'B')
      expect(command).to receive(:color_pixel).with('2', '2', 'B')
      expect(command).to receive(:color_pixel).with('2', '3', 'B')
      command.color_column('2', '1', '3', 'B')
    end
  end

  describe '#color_row' do
    it "colors row 2 from column 1 to column 3" do
      expect(command).to receive(:color_pixel).with('1', '2', 'B')
      expect(command).to receive(:color_pixel).with('2', '2', 'B')
      expect(command).to receive(:color_pixel).with('3', '2', 'B')
      command.color_row('2', '1', '3', 'B')
    end
  end
end
