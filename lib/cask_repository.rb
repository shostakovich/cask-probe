require 'castic'

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
