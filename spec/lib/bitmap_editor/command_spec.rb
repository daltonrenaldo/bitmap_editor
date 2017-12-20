require 'spec_helper'
require './lib/bitmap_editor/command'

describe BitmapEditor::Command do
  let(:command) { described_class.new(bitmap) }
  let(:bitmap) { bitmap = double('bitmap') }

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
      expect(bitmap).to receive(:set_pixel_to).with({x: 2, y: 4}, 'B')
      command.color_pixel('2', '4', 'B')
    end
  end

  describe '#color_column' do
  end

  describe '#color_row' do
  end
end
