class DownloadAuditor
  attr_reader :cask, :download_path, :cask_name

  def initialize(cask)
    @cask = cask
    @download_path =  "/tmp/#{cask.name}"
    @cask_name = cask_name
  end

  def check(reporter)
    download(cask)
    if cask.sha1 && !hash_matches?(cask)
      reporter.report(self, :failed, "sha1 does not match")
    else
      reporter.report(self, :passed)
    end
  end

  private
  def hash_matches?(cask)
    cask.sha1 == sha1(download_path)
  end

  def download(cask)
    `curl -Ls #{cask.url} > #{download_path}`
  end

  def sha1(file)
    `shasum #{download_path} | awk '{print $1}'`
  end
end
