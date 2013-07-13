require 'spec_helper'
require_relative '../lib/git_hub_issue_reporter'

describe 'GitHubIssueReporter' do
  context 'for a failed audit' do
    it 'creates an issue on github' do
      client = double('GithubClient')
      client.should_receive(:create_issue)
      auditor = stub(:cask_name => 'Foo.app') 

      reporter = GitHubIssueReporter.new(client)
      reporter.report(auditor, :failed) 
    end
  end

  context 'for a passed audit' do
    it 'does nothing' do
      client = double('GithubClient')
      client.should_not_receive(:create_issue)
      auditor = stub(:cask_name => 'Foo.app') 

      reporter = GitHubIssueReporter.new(client)
      reporter.report(auditor, :passed) 
    end
  end
end
