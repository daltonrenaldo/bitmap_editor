require './lib/bitmap_editor'
require 'spec_helper'
require 'stringio'

describe BitmapEditor do
  describe '#run' do
    context 'input file is invalid' do
      before do
        expect(STDOUT).to receive(:puts).with("please provide correct file")
      end

      it { subject.run(nil) }
      it do
        allow(File).to receive(:exists?).with('non-existant-file').and_return(false)
        subject.run('non-existant-file')
      end
    end

    context 'input file is valid' do
      let(:filename) { 'valid-file.txt' }
      let(:commandor) { double('BitmapEditor::Command') }

      before do
        allow(File).to receive(:exists?).and_return(true)
        allow(File).to receive(:open).with(filename).and_return(file_content)
      end

      context 'reads create bitmap command' do
        let(:file_content) { StringIO.new("I 5 5") }
        let(:bitmap_instance) { Bitmap.new(5, 5) }

        it "creates the bitmap" do
          expect(Bitmap).to receive(:new).with(5, 5)
          subject.run(filename)
        end
      end

      context 'reads show bitmap command' do
        let(:file_content) { StringIO.new("S") }

        it "outputs the bitmap" do
          allow(subject).to receive(:commandor).and_return(commandor)
          expect(commandor).to receive(:render_bitmap)
          subject.run filename
        end
      end
    end
  end
end
