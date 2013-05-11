require 'rspec'
require 'guard/tap'

RSpec.configure do |config|

  config.before(:each) do
    ENV["GUARD_ENV"] = 'test'
    @project_path    = Pathname.new(File.expand_path('../../', __FILE__))

    Guard::UI.stub(:info)
    Guard::UI.stub(:debug)
    Guard::UI.stub(:error)
    Guard::UI.stub(:success)
    Guard::UI.stub(:warning)
    Guard::UI.stub(:notify)
  end

  config.after(:each) do
    ENV["GUARD_ENV"] = nil
  end

end
