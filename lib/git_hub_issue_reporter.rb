require 'octokit'
class GitHubIssueReporter
  def initialize(client)
    @client = client
  end

  def report(auditor, status, message="")
    return unless status == :failed

    @client.create_issue("shostakovich/cask-probe", "Cask #{auditor.cask_name} is broken", message)
  end
end
