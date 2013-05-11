require 'spec_helper'

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
  end

  describe '#notify' do
    before do
      runner.unstub(:notify)
    end

    it 'calls UI and Notifier' do
      Guard::UI.should_receive(:info).with('hi')
      Guard::Notifier.should_receive(:notify).with('hi', foo: 'bar')
      runner.notify 'hi', foo: 'bar'
    end
  end

  describe '#notify_success' do
    it 'calls notify with image: success' do
      runner.should_receive(:notify).with('hi', image: :success)
      runner.notify_success('hi')
    end
  end

  describe '#notify_error' do
    it 'calls notify with image: failed' do
      runner.should_receive(:notify).with('hi', image: :failed)
      runner.notify_error('hi')
    end
  end

end
