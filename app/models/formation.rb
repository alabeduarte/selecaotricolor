class Formation
  include MongoMapper::Document
  
  many :players_positions, :class_name => 'PlayerFormationPosition'
  
  def self.create_from(data)
    players_positions = Array.new
    data.each do |item|
      element_value = item["formation"]["player"]
      x_value = item["formation"]["x"]
      y_value = item["formation"]["y"]
      
      players_positions << PlayerFormationPosition.new(:player => Player.find_by_number(element_value.to_i), :x => x_value, :y => y_value)
    end
    Formation.new :players_positions => players_positions
  end
  
end
