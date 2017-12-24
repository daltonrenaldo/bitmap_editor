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
        allow(subject).to receive(:commandor).and_return(commandor)
      end

      after do
        subject.run(filename)
      end

      context 'reads in create bitmap command' do
        let(:file_content) { StringIO.new("I 5 6") }

        it "creates the bitmap" do
          expect(Bitmap).to receive(:new).with(6, 5)
        end

        context 'intended sizes too large' do
          let(:file_content) { StringIO.new("I 251 1") }

          it 'indicates size is too large' do
            expect(STDOUT).to receive(:puts).with('Cannot Create Bitmap: Sizes must be between 1 - 250')
          end
        end

        context 'intended sizes too small' do
          let(:file_content) { StringIO.new("I 0 250") }

          it 'indicates size is too small' do
            expect(STDOUT).to receive(:puts).with('Cannot Create Bitmap: Sizes must be between 1 - 250')
          end
        end
      end

      context 'reads in show bitmap command' do
        let(:file_content) { StringIO.new("S") }
        let(:bitmap) { double('Bitmap') }

        before do
          allow(subject).to receive(:bitmap).and_return(bitmap)
        end

        it "executes render_bitmap command" do
          expect(commandor).to receive(:perform).with(:render_bitmap)
        end
      end

      context 'reads in clear bitmap command' do
        let(:file_content) { StringIO.new("C") }

        it 'executes clear_bitmap command' do
          expect(commandor).to receive(:perform).with(:clear_bitmap)
        end
      end

      context 'reads in color pixel command' do
        let(:file_content) { StringIO.new("L 4 2 A") }

        it 'executes color_pixel command' do
          expect(commandor).to receive(:perform).with(:color_pixel, '4', '2', 'A')
        end
      end

      context 'reads in color column segment command' do
        let(:file_content) { StringIO.new('V 3 1 3 A') }

        it "executes color_column" do
          expect(commandor).to receive(:perform).with(:color_column, '3', '1', '3', 'A')
        end
      end

      context 'reads in color row segment command' do
        let(:file_content) { StringIO.new('H 1 3 2 A') }

        it "executes color_row" do
          expect(commandor).to receive(:perform).with(:color_row, '2', '1', '3', 'A')
        end
      end

      context 'reads in invalid command' do
        ['V 3 1 3 a', 'F', 'C 3 1 3 A', 'V313A', 's'].each do |invalid_command|
          let(:file_content) { StringIO.new(invalid_command) }

          it "outputs 'unrecognised command :('" do
            expect(STDOUT).to receive(:puts).with("unrecognised command :(")
          end
        end
      end
    end
  end
end
