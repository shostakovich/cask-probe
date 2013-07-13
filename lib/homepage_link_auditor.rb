require 'curb'
class HomepageLinkAuditor
  attr_reader :cask, :cask_name

  def initialize(cask)
    @cask = cask
    @cask_name = cask.name
  end

  def check(reporter)
    response = Curl::Easy.perform(@cask.homepage)

    if(response.status == '200 OK')
      reporter.report(self, :passed)
    else
      reporter.report(self, :failed, response)
    end
  rescue Curl::Err::ConnectionFailedError => e
    reporter.report(self, :failed, e.message)
  end
end
