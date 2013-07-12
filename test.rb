require 'castic'
require 'virtus'

class Cask
  include Virtus
  
  attribute :name, String
  attribute :url, String
  attribute :sha1, String
end

class CaskRepository
  def self.all
     Dir["Casks/*.rb"].map do |f|
      c = Castic.new(f, :Cask)

      cask = {name: c.name}
      c.props.each do |prop|
        attribute = prop[0]
        value = prop[1] && prop[1][0]
        cask[attribute] = value
      end

      Cask.new(cask)
    end
  end
end

def sha1(file)
  `sha1 /tmp/#{cask.name}`
end

class CaskDownloadChecker
  attr_reader :cask

  def initialize(cask)
    @cask = cask
  end

  def check
    puts "Downloading #{cask.name}"

    download_path =  "/tmp/#{cask.name}"
    `curl -Ls #{cask.url} > #{download_path}`

    require 'digest/sha1'
    if cask.sha1
      false if cask.sha1 != sha1(download_path)
    else
      true
    end
  end
end

CaskRepository.all.each do |cask|
  puts CaskDownloadChecker.new(cask).check
end
