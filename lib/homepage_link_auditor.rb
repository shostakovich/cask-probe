require 'curb'
class HomepageLinkAuditor
  def initialize(cask)
    @cask = cask  
  end

  def check(reporter)
    response = Curl::Easy.perform(@cask.homepage)

    if(response.status == '200 OK')
      reporter.report(self, :passed)
    else
      reporter.report(self, :failed, response)
    end
  end
end
