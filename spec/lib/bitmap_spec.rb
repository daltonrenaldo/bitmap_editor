require 'spec_helper'
require './lib/bitmap'

describe Bitmap do
  describe 'initialize' do
    let(:rows) { 3 }
    let(:cols) { 4 }
    let(:bitmap) { Bitmap.new(rows, cols) }

    it "creates an m x n empty bitmap" do
      expect(bitmap.bitmap).to eql([
        ["O", "O", "O", "O"],
        ["O", "O", "O", "O"],
        ["O", "O", "O", "O"]
      ])
    end
  end

  describe '#to_s' do
    let(:bitmap) { Bitmap.new(4, 4) }
    it "represents bitmap as string" do
      expect(bitmap.to_s).to eql("OOOO\nOOOO\nOOOO\nOOOO")
    end
  end
end
