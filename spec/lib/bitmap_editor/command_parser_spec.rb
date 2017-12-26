require 'spec_helper'
require './lib/bitmap_editor/command_parser';

describe BitmapEditor::CommandParser do
  describe '#parse' do
    subject { described_class.new.parse(line) }

    context 'line is "I 3 3"' do
      let(:line) { "I 3 3" }
      it { is_expected.to eql([:create_bitmap, 3, 3]) }
    end

    context 'line is "C"' do
      let(:line) { 'C' }
      it { is_expected.to eql([:clear]) }
    end

    context 'line is "L 4 4 O"' do
      let(:line) { 'L 4 4 O' }
      it { is_expected.to eql([:color_pixel, 4, 4, 'O']) }
    end

    context 'line is "V 2 3 6 W"' do
      let(:line) { 'V 2 3 6 W' }
      it { is_expected.to eql([:color_column, 2, 3, 6, 'W']) }
    end

    context 'line is "H 3 5 2 Z"' do
      let(:line) { 'H 3 5 2 Z' }
      it { is_expected.to eql([:color_row, 3, 5, 2, 'Z']) }
    end

    context 'line is "S"' do
      let(:line) { 'S' }
      it { is_expected.to eql([:render_bitmap]) }
    end

    context 'line format is unrecognised' do
      let(:line) { 'unrecognised' }
      it 'raises error' do
        expect{subject}.to raise_error BitmapEditor::CommandParser::UnknownCommandError
      end
    end
  end
end
