require 'rspec'
require 'guard/tap'

RSpec.configure do |config|

  config.before(:each) do
    ENV["GUARD_ENV"] = 'test'
    @project_path    = Pathname.new(File.expand_path('../../', __FILE__))

    Guard::Compat::UI.stub(:info)
    Guard::Compat::UI.stub(:debug)
    Guard::Compat::UI.stub(:error)
    Guard::Compat::UI.stub(:success)
    Guard::Compat::UI.stub(:warning)
    Guard::Compat::UI.stub(:notify)
  end

  config.after(:each) do
    ENV["GUARD_ENV"] = nil
  end

end
