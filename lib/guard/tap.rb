require "guard/tap/version"

require 'guard'
require 'guard/watcher'
require 'guard/compat/plugin'

require 'shellwords'

module Guard
  class Tap < Plugin

    autoload :Runner, 'guard/tap/runner'

    def run_on_changes paths
      paths.each{ |path|
        Runner.run make_command(path), path
      }
    end

    def make_command path
      if options[:command]
        "#{options[:command]} #{Shellwords.escape path} 2>&1"
      else
        "#{Shellwords.escape path} 2>&1"
      end
    end
  end
end
