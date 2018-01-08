require 'spec_helper'
require './lib/bitmap'

describe Bitmap do
  describe '#create_bitmap' do
    let(:error_message) { 'Cannot Create Bitmap: Sizes must be between 1 - 250' }
    it "creates blank bitmap" do
      subject.create_bitmap(4, 3)
      expect(subject.bitmap).to eql([
        ["O", "O", "O", "O"],
        ["O", "O", "O", "O"],
        ["O", "O", "O", "O"]
      ])
    end

    it "creates an m x n bitmap of a given color" do
      subject.create_bitmap(4, 3, "R")
      expect(subject.bitmap).to eql([
        ["R", "R", "R", "R"],
        ["R", "R", "R", "R"],
        ["R", "R", "R", "R"]
      ])
    end

    context 'intended sizes too large' do
      it 'indicates size is too large' do
        expect(STDOUT).to receive(:puts).with(error_message)
        subject.create_bitmap(1, 251)
      end
    end

    context 'intended sizes too small' do
      it 'indicates size is too small' do
        expect(STDOUT).to receive(:puts).with(error_message)
        subject.create_bitmap(250, 0)
      end
    end
  end

  describe '#clear' do
    before do
      subject.create_bitmap(3, 3, 'R')
    end

    it "sets all pixels back to white (O)" do
      expect(subject.clear).to eql([
        ["O", "O", "O"],
        ["O", "O", "O"],
        ["O", "O", "O"]
      ])
    end
  end

  describe '#color_pixel' do
    let (:original_image) do
      [
        ["O", "O", "O"],
        ["O", "O", "O"],
        ["O", "O", "O"]
      ]
    end

    before do
      subject.create_bitmap(3, 3)
    end

    it "changes the color of a given pixel to the given color" do
      subject.color_pixel(2, 1, 'R')
      expect(subject.bitmap).to eql([
        ["O", "R", "O"],
        ["O", "O", "O"],
        ["O", "O", "O"]
      ])
    end

    context ":x coordinates is out of range" do
      it 'ignores out of upperbound' do
        subject.color_pixel(4, 1, 'R')
        expect(subject.bitmap).to eql(original_image)
      end

      it 'ignores values less than 1' do
        subject.color_pixel(0, 1, 'R')
        expect(subject.bitmap).to eql(original_image)
      end
    end

    context ":y coordinates is out of range" do
      it 'does nothing' do
        subject.color_pixel(1, 4, 'R')
        expect(subject.bitmap).to eql(original_image)
      end

      it 'ignores values less than 1' do
        subject.color_pixel(1, 0, 'R')
        expect(subject.bitmap).to eql(original_image)
      end
    end
  end

  describe '#to_s' do
    it "represents bitmap as string" do
      subject.create_bitmap(4, 4)
      expect(subject.to_s).to eql("OOOO\nOOOO\nOOOO\nOOOO")
    end
  end

  describe '#render_bitmap' do
    it "renders the bitmap" do
      expect(STDOUT).to receive(:puts).with(subject)
      subject.render_bitmap
    end
  end

  describe '#color_column' do
    it "colors column 2 from row 1 to row 3" do
      subject.create_bitmap(3, 3)
      subject.color_column('2', '1', '3', 'B')
      expect(subject.bitmap).to eql([["O", "B", "O"], ["O", "B", "O"], ["O", "B", "O"]])
    end
  end

  describe '#color_row' do
    it "colors row 2 from column 1 to column 3" do
      subject.create_bitmap(3, 3)
      subject.color_row('1', '3', '2', 'B')
      expect(subject.bitmap).to eql([["O", "O", "O"], ["B", "B", "B"], ["O", "O", "O"]])
    end
  end

  describe '#flood_fill' do
    let(:bitmap) do
      [
        ["0", "0", "X", "0", "0"],
        ["0", "0", "X", "0", "0"],
        ["0", "0", "X", "0", "0"]
      ]
    end

    before do
      allow(subject).to receive(:bitmap).and_return(bitmap)
      allow(subject).to receive(:rows).and_return(3)
      allow(subject).to receive(:cols).and_return(5)
    end

    context 'scenario 1' do
      it 'flood/bucket fill the surrounding pixels of the same color' do
        subject.flood_fill(2, 2, 'R')
        expect(bitmap).to eq ([
          ["R", "R", "X", "0", "0"],
          ["R", "R", "X", "0", "0"],
          ["R", "R", "X", "0", "0"]
        ])
      end
    end

    context 'scenario 2' do
      it 'flood/bucket fill the surrounding pixels of the same color' do
        subject.flood_fill(3, 1, 'R')
        expect(bitmap).to eq ([
          ["0", "0", "R", "0", "0"],
          ["0", "0", "R", "0", "0"],
          ["0", "0", "R", "0", "0"]
        ])
      end
    end

    context 'scenario 3' do
      it 'does not get into infinite loop' do
        subject.flood_fill(3, 1, 'X')
        expect(bitmap).to eq ([
          ["0", "0", "X", "0", "0"],
          ["0", "0", "X", "0", "0"],
          ["0", "0", "X", "0", "0"]
        ])
      end
    end
  end
end
