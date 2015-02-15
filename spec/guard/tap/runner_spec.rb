require 'spec_helper'
require 'guard/compat/test/helper'

describe Guard::Tap::Runner do

  let(:runner) { Guard::Tap::Runner }

  before do
    runner.stub(:notify)
  end

  describe '#run' do
    it 'returns true when success' do
      runner.run('pwd').should == true
    end

    it 'returns false when failed' do
      runner.run('undefined_method').should == false
    end

    it 'handles ok' do
      runner.should_not_receive(:notify_error)
      runner.run('echo ok 1')
    end

    it 'handles not ok' do
      runner.should_receive(:notify_error).with(/^not ok 1/)
      runner.run('echo not ok 1')
    end

    it 'handles not ok (TODO)' do
      runner.should_not_receive(:notify_error)
      runner.run('echo not ok 1 \\# TODO')
    end
  end

  describe '#notify' do
    before do
      runner.unstub(:notify)
    end

    it 'calls UI and Notifier' do
      Guard::Compat::UI.should_receive(:info).with('hi')
      Guard::Notifier.should_receive(:notify).with('hi', foo: 'bar')
      runner.notify :info, 'hi', foo: 'bar'
    end
  end

  describe '#notify_success' do
    it 'calls notify with image: success' do
      runner.should_receive(:notify).with(:info, 'hi', image: :success)
      runner.notify_success('hi')
    end
  end

  describe '#notify_error' do
    it 'calls notify with image: failed' do
      runner.should_receive(:notify).with(:error, 'hi', image: :failed)
      runner.notify_error('hi')
    end
  end

end
