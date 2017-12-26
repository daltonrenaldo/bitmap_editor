require 'spec_helper'
require './lib/bitmap_editor'

describe 'executing command file' do
  context 'happy scenario with all possible commands' do
    it do
      expect(STDOUT).to receive(:puts) do |bitmap|
        expect(bitmap.to_s).to eql "OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO"
      end

      BitmapEditor.new.run './spec/fixtures/input1.txt';
    end
  end

  context 'with bitmap create command twice' do
    it do
      expect(STDOUT).to receive(:puts) do |bitmap|
        expect(bitmap.to_s).to eql "OOO\nOOZ\nOOO"
      end

      BitmapEditor.new.run './spec/fixtures/double-create.txt';
    end
  end

  context 'showing bitmap with no bitmap' do
    xit do
      expect(STDOUT).to_not receive(:puts)
      BitmapEditor.new.run './spec/fixtures/no-bitmap.txt';
    end
  end
end
