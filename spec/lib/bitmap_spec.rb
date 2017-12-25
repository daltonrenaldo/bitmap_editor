require 'spec_helper'
require './lib/bitmap'

describe Bitmap do
  describe 'initialize' do
    let(:rows) { 3 }
    let(:cols) { 4 }

    it "creates an m x n empty bitmap" do
      bitmap = Bitmap.new(rows, cols)
      expect(bitmap.bitmap).to eql([
        ["O", "O", "O", "O"],
        ["O", "O", "O", "O"],
        ["O", "O", "O", "O"]
      ])
    end

    it "creates an m x n bitmap of a given color" do
      bitmap = Bitmap.new(rows, cols, 'R')
      expect(bitmap.bitmap).to eql([
        ["R", "R", "R", "R"],
        ["R", "R", "R", "R"],
        ["R", "R", "R", "R"]
      ])
    end
  end

  describe '#clear' do
    let(:bitmap) { Bitmap.new(3, 3, "R") }

    it "sets all pixels back to white (O)" do
      expect(bitmap.clear).to eql([
        ["O", "O", "O"],
        ["O", "O", "O"],
        ["O", "O", "O"]
      ])
    end
  end

  describe '#set_pixel_to' do
    let (:bitmap) { Bitmap.new(3, 3) }
    let (:original_image) do
      [
        ["O", "O", "O"],
        ["O", "O", "O"],
        ["O", "O", "O"]
      ]
    end

    it "changes the color of a given pixel to the given color" do
      bitmap.set_pixel_to({x: 1, y: 0}, 'R')
      expect(bitmap.bitmap).to eql([
        ["O", "R", "O"],
        ["O", "O", "O"],
        ["O", "O", "O"]
      ])
    end

    context ":x coordinates is out of range" do
      it 'ignores out of upperbound' do
        bitmap.set_pixel_to({x: 3, y: 0}, 'R')
        expect(bitmap.bitmap).to eql(original_image)
      end

      it 'ignores values less than 0' do
        bitmap.set_pixel_to({x: -1, y: 0}, 'R')
        expect(bitmap.bitmap).to eql(original_image)
      end
    end

    context ":y coordinates is out of range" do
      it 'does nothing' do
        bitmap.set_pixel_to({x: 0, y: 3}, 'R')
        expect(bitmap.bitmap).to eql(original_image)
      end

      it 'ignores values less than 0' do
        bitmap.set_pixel_to({x: 0, y: -1}, 'R')
        expect(bitmap.bitmap).to eql(original_image)
      end
    end
  end

  describe '#to_s' do
    let(:bitmap) { Bitmap.new(4, 4) }
    it "represents bitmap as string" do
      expect(bitmap.to_s).to eql("OOOO\nOOOO\nOOOO\nOOOO")
    end
  end
end
