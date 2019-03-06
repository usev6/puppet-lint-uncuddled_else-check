require 'spec_helper'

# rubocop:disable Metrics/BlockLength, Metrics/LineLength
describe 'uncuddled_else' do
  ## uncuddled else
  context 'with fix disabled' do
    let(:msg) { 'found uncuddled else, should be on same line as closing curly' }

    ## no indentation
    context 'else on same line as closing curly of preceding if block' do
      let(:code) { "if $foo == 'bar' {\n  ## some stuff\n} else {\n  ## other stuff\n}\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'else on next line after closing curly of preceding if block' do
      let(:code) { "if $foo == 'bar' {\n  ## some stuff\n}\nelse {\n  ## other stuff\n}\n" }

      it 'should detect a single problems' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(4).in_column(1)
      end
    end

    ## with indentation
    context 'else on same line as indented closing curly of preceding if block' do
      let(:code) { "  if $foo == 'bar' {\n    ## some stuff\n  } else {\n    ## other stuff\n  }\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'indented else on next line after closing curly of preceding if block' do
      let(:code) { "  if $foo == 'bar' {\n    ## some stuff\n  }\n  else {\n    ## other stuff\n  }\n" }

      it 'should detect a single problems' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(4).in_column(3)
      end
    end
  end

  ## uncuddled elsif
  context 'with fix disabled' do
    let(:msg) { 'found uncuddled elsif, should be on same line as closing curly' }

    ## no identation
    context 'elsif on same line as closing curly of preceding if block' do
      let(:code) { "if $foo == 'bar' {\n  ## some stuff\n} elsif $foo == 'baz' {\n  ## other stuff\n}\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'elsif on next line after closing curly of preceding if block' do
      let(:code) { "if $foo == 'bar' {\n  ## some stuff\n}\nelsif $foo == 'baz' {\n  ## other stuff\n}\n" }

      it 'should detect a single problems' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(4).in_column(1)
      end
    end

    ## with identation
    context 'indented elsif on same line as closing curly of preceding if block' do
      let(:code) { "  if $foo == 'bar' {\n    ## some stuff\n  } elsif $foo == 'baz' {\n    ## other stuff\n  }\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end

    context 'elsif on next line after indented closing curly of preceding if block' do
      let(:code) { "  if $foo == 'bar' {\n    ## some stuff\n  }\n  elsif $foo == 'baz' {\n    ## other stuff\n  }\n" }

      it 'should detect a single problems' do
        expect(problems).to have(1).problems
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(4).in_column(3)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/LineLength
