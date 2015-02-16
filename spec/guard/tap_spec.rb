require 'spec_helper'
require 'guard/compat/test/helper'

describe Guard::Tap do

  let(:guard) { Guard::Tap.new }

  let(:runner) { Guard::Tap::Runner }

  before do
    runner.stub(:run)
  end

  describe '#initialize' do
    it 'has empty option' do
      guard.options.should == { }
    end
  end

  describe '#run_on_changes' do
    it 'starts the Runner with the changed file' do
      runner.should_receive(:run).with('test.pl 2>&1', 'test.pl').ordered
      guard.run_on_changes(['test.pl'])
    end

    it 'starts the Runner with the each changed files' do
      runner.should_receive(:run).with('test1.pl 2>&1', 'test1.pl').ordered
      runner.should_receive(:run).with('test2.pl 2>&1', 'test2.pl').ordered
      guard.run_on_changes(['test1.pl', 'test2.pl'])
    end
  end

  describe '#make_command' do
    it 'makes the shell command for Runner' do
      guard.make_command('test.pl').should == 'test.pl 2>&1'
    end

    it 'escapes path' do
      guard.make_command('the test.pl').should == 'the\ test.pl 2>&1'
    end

    context 'with the :command option' do
      let(:guard) { Guard::Tap.new(:command => 'perl') }

      it 'makes the command with specified command' do
        guard.make_command('test.pl').should == 'perl test.pl 2>&1'
      end
    end
  end

end
