require 'spec_helper'
require './lib/bitmap_editor/command'

describe BitmapEditor::Command do
  let(:bitmap) { double('bitmap') }

  before do
    allow(subject).to receive(:bitmap).and_return(bitmap)
  end

  describe '#perform' do
    it "runs the given method with the given params" do
      expect(subject).to receive(:color_pixel).with(1, 1, 'F')
      subject.perform(:color_pixel, 1, 1, 'F')
    end

    context 'bitmap does not exists' do
      let(:bitmap) { nil }

      it 'does nothing' do
        expect(subject).to_not receive(:clear_bitmap)
        subject.perform(:clear_bitmap)
      end

      context 'when command is to create bitmap' do
        it 'creates bitmap' do
          expect(subject).to receive(:create_bitmap).with(1, 2)
          subject.perform(:create_bitmap, 1, 2)
        end
      end
    end
  end

  describe '#create_bitmap' do
    it "creates the bitmap" do
      expect(Bitmap).to receive(:new).with(6, 5)
      subject.create_bitmap(5, 6)
    end

    context 'intended sizes too large' do
      it 'indicates size is too large' do
        expect(STDOUT).to receive(:puts).with('Cannot Create Bitmap: Sizes must be between 1 - 250')
        subject.create_bitmap(1, 251)
      end
    end

    context 'intended sizes too small' do
      it 'indicates size is too small' do
        expect(STDOUT).to receive(:puts).with('Cannot Create Bitmap: Sizes must be between 1 - 250')
        subject.create_bitmap(250, 0)
      end
    end
  end

  describe '#render_bitmap' do
    it "renders the bitmap" do
      expect(STDOUT).to receive(:puts).with(bitmap)
      subject.render_bitmap
    end
  end

  describe '#clear_bitmap' do
    it "clears the bitmap" do
      expect(bitmap).to receive(:clear)
      subject.clear_bitmap
    end
  end

  describe '#color_pixel' do
    it "colors the given pixel coordinate of the bitmap" do
      expect(bitmap).to receive(:set_pixel_to).with({x: 1, y: 3}, 'B')
      subject.color_pixel('2', '4', 'B')
    end
  end

  describe '#color_column' do
    it "colors column 2 from row 1 to row 3" do
      expect(subject).to receive(:color_pixel).with('2', '1', 'B')
      expect(subject).to receive(:color_pixel).with('2', '2', 'B')
      expect(subject).to receive(:color_pixel).with('2', '3', 'B')
      subject.color_column('2', '1', '3', 'B')
    end
  end

  describe '#color_row' do
    it "colors row 2 from column 1 to column 3" do
      expect(subject).to receive(:color_pixel).with('1', '2', 'B')
      expect(subject).to receive(:color_pixel).with('2', '2', 'B')
      expect(subject).to receive(:color_pixel).with('3', '2', 'B')
      subject.color_row('1', '3', '2', 'B')
    end
  end
end
