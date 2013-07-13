require 'pp'
class DebugReporter
  def report(check, outcome, message="")
    pp check, outcome, message
  end
end
