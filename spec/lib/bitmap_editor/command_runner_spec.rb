require 'spec_helper'
require './lib/bitmap_editor/command_runner';

describe BitmapEditor::CommandRunner do
  let(:bitmap) { double('Bitmap') }

  describe '#execute' do
    before do
      allow(subject).to receive(:bitmap).and_return(bitmap)
    end

    context 'bitmap responds to line command' do
      before do
        allow(bitmap).to receive(:respond_to?).with("i").and_return(true)
      end

      it 'perfoms the command' do
        expect(bitmap).to receive(:i).with(3, 4)
        subject.execute("I 3 4")
      end
    end

    context 'bitmap does not respond to line command' do
      before do
        allow(bitmap).to receive(:respond_to?).with('j').and_return(false)
      end

      it 'outputs unrecognised command' do
        expect(STDOUT).to receive(:puts).with("unrecognised command :(")
        subject.execute("J 2 1 4")
      end
    end

    context 'line has invalid format' do
      it 'does nothing' do
        expect(subject.execute("04")).to eql nil
      end
    end

  end
end
