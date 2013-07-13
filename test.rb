require_relative './lib/cask'
require_relative './lib/cask_repository'
require_relative './lib/download_auditor'
require_relative './lib/homepage_link_auditor'
require_relative './lib/debug_reporter'
require_relative './lib/git_hub_issue_reporter'
require_relative './lib/distributing_reporter'

auditors = [HomepageLinkAuditor, DownloadAuditor]

class GitHubClient
  def create_issue(*args)
    pp args
  end
end

reporter = DistributingReporter.new([DebugReporter.new, GitHubIssueReporter.new(GitHubClient.new)])

CaskRepository.all.each do |cask|
  auditors.each do |auditor| 
    auditor.new(cask).check(reporter)
  end
end
