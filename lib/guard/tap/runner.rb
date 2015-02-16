module Guard
  class Tap
    module Runner
      class << self

        def run command, title = command
          notify :info, "runnning: #{title}"

          now_error = false
          error_message = ''
          flush_error = lambda {
            next unless error_message.length > 0
            notify_error error_message
            error_message = ''
          }

          IO.popen(command, "r+"){ |io|
            while line = io.gets
              ::Guard::Compat::UI.debug line
              if line =~ /^ok/
                now_error = false
                flush_error.call
              elsif line =~ /^\d+.{2}\d+$/
                now_error = false
                flush_error.call
              elsif line =~ /^not ok/
                flush_error.call
                now_error = (line =~ / # TODO/ ? false : true)
              end
              if now_error
                error_message << line
              end
            end
          }
          flush_error.call

          if $?.success?
            notify_success "success: #{title}"
          else
            notify_error "failed: #{title}"
          end

          $?.success?
        rescue SystemCallError
          notify_error "failed: #{title}"
          false
        end

        def notify log_level, message, args = { }
          ::Guard::Compat::UI.send log_level, message
          ::Guard::Notifier.notify message, args
        end

        def notify_success message
          notify :info, message, image: :success
        end

        def notify_error message
          notify :error, message, image: :failed
        end

      end
    end
  end
end
