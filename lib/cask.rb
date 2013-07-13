require 'virtus'

class Cask
  include Virtus
  
  attribute :name, String
  attribute :url, String
  attribute :sha1, String
  attribute :homepage, String
end
