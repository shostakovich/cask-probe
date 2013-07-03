require 'castic'
require 'virtus'
require 'curb'

class Cask
  include Virtus
  
  attribute :name, String
  attribute :url, String
  attribute :sha1, String
end

casks = Dir["Casks/*.rb"].map do |f|
  c = Castic.new(f, :Cask)
  
  cask = {name: c.name}
  c.props.each do |prop|
    attribute = prop[0]
    value = prop[1] && prop[1][0]
    cask[attribute] = value
  end

  Cask.new(cask)
end

casks.each do |cask|
  puts "Downloading #{cask.name}"
  
  download = Curl::Easy.new(cask.url)
  download.follow_location = true
  download.perform

  require 'digest/sha1'
  if cask.sha1
    puts "Error" if cask.sha1 != Digest::SHA1.hexdigest(download.body_str)
  else
    puts "Success"
  end
end
