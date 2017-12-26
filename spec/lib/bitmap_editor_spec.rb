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
      let(:command_parser) { double('BitmapEditor::CommandParser') }
      let(:bitmap) { double('Bitmap') }
      let(:file_content) { StringIO.new('I 5 5') }

      before do
        allow(File).to receive(:exists?).and_return(true)
        allow(File).to receive(:open).with(filename).and_return(file_content)
        allow(subject).to receive(:command_parser).and_return(command_parser)
        allow(command_parser).to receive(:parse).and_return([:create, 5, 5])
        allow(subject).to receive(:bitmap).and_return(bitmap)
      end

      it "executes the line" do
        expect(bitmap).to receive(:create).with(5, 5)
        subject.run(filename)
      end
    end
  end
end
