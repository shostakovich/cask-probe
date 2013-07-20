require_relative './lib/cask'
require_relative './lib/cask_repository'
require_relative './lib/download_auditor'
require_relative './lib/homepage_link_auditor'
require_relative './lib/debug_reporter'
require_relative './lib/git_hub_issue_reporter'
require_relative './lib/distributing_reporter'
require 'octokit'
require 'yaml'
require 'sidekiq'

class CaskAuditor
  include Sidekiq::Worker
  
  def perform(cask_file)
    cask = Cask.from_file_name(cask_file)

    auditors.each do |auditor| 
      auditor.new(cask).check(reporter)
    end
  end

  private
  def client
    @client ||= Octokit::Client.new(:login => credentials["username"], :password => credentials["password"])
  end

  def credentials
    YAML.load_file('/Users/shostakovich/.caskprobe').fetch("github")
  end

  def reporter
    DistributingReporter.new([DebugReporter.new, GitHubIssueReporter.new(client)])
  end

  def auditors
    [HomepageLinkAuditor, DownloadAuditor]
  end
end

#Dir["Casks/*.rb"].map do |f|
#  CaskAuditor.perform_async(f)
#end
