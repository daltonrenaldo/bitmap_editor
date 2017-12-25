require 'spec_helper'
require './lib/bitmap_editor/command_runner';

describe BitmapEditor::CommandRunner do
  let(:commandor) { double('BitmapEditor::Command') }

  describe '#execute' do
    before do
      allow(subject).to receive(:commandor).and_return(commandor)
    end

    context 'commandor responds to line command' do
      before do
        allow(commandor).to receive(:respond_to?).with("i").and_return(true)
      end

      it 'perfoms the command' do
        expect(commandor).to receive(:perform).with("i", 3, 4)
        subject.execute("I 3 4")
      end
    end

    context 'commandor does not respond to line command' do
      before do
        allow(commandor).to receive(:respond_to?).with('j').and_return(false)
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
