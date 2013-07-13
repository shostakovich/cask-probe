require_relative './lib/cask'
require_relative './lib/cask_repository'
require_relative './lib/download_auditor'
require_relative './lib/homepage_link_auditor'
require_relative './lib/debug_reporter'
require_relative './lib/git_hub_issue_reporter'
require_relative './lib/distributing_reporter'
require 'octokit'
require 'yaml'

auditors = [HomepageLinkAuditor, DownloadAuditor]

credentials = YAML.load_file('/Users/shostakovich/.caskprobe').fetch("github")
client = Octokit::Client.new(:login => credentials["username"], :password => credentials["password"])

reporter = DistributingReporter.new([DebugReporter.new, GitHubIssueReporter.new(client)])

CaskRepository.all.each do |cask|
  auditors.each do |auditor| 
    auditor.new(cask).check(reporter)
  end
end
