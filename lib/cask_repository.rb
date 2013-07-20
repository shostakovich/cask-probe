require 'castic'

class Cask
  def self.from_file_name(file_name)
      parsed_file = Castic.new(file_name, :Cask)

      cask_attributes = {name: parsed_file.name}
      parsed_file.props.each do |prop|
        attribute = prop[0]
        value = prop[1] && prop[1][0]
        cask_attributes[attribute] = value
      end

      Cask.new(cask_attributes)
  end
end
