require_relative './lib/cask'
require_relative './lib/cask_repository'
require_relative './lib/download_auditor'
require_relative './lib/homepage_link_auditor'

class Reporter
  def report(check, outcome, message="")
    p check, outcome, message
  end
end


auditors = [HomepageLinkAuditor, DownloadAuditor]
reporter = Reporter.new

CaskRepository.all.each do |cask|
  auditors.each do |auditor| 
    auditor.new(cask).check(reporter)
  end
end
