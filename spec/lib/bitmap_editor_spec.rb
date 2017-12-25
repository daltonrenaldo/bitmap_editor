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
      let(:command_runner) { double('BitmapEditor::CommandRunner') }
      let(:file_content) { StringIO.new('I 5 5') }

      before do
        allow(File).to receive(:exists?).and_return(true)
        allow(File).to receive(:open).with(filename).and_return(file_content)
        allow(subject).to receive(:command_runner).and_return(command_runner)
      end

      it "execute the line" do
        expect(command_runner).to receive(:execute).with("I 5 5")
        subject.run(filename)
      end
    end
  end
end
