require 'curb'
class HomepageLinkAuditor
  attr_reader :cask, :cask_name

  def initialize(cask)
    @cask = cask
    @cask_name = cask.name
  end

  def check(reporter)
    begin
      response = Curl::Easy.perform(@cask.homepage)
    rescue Curl::Err::ConnectionFailedError => e
      return reporter.report(self, :failed, e.message)
    end

    case response.status[/[0-9]+/]
    when '200', '301', '302'
      reporter.report(self, :passed)
    else
      reporter.report(self, :failed, "Homepage link is broken")
    end
  end
end
