require 'pp'
class DebugReporter
  def report(check, outcome, message="")
    puts "#{check.cask_name} (#{check.class}): #{outcome}"
  end
end
