class Formation
  include MongoMapper::Document
  self.include_root_in_json = true
  
  many :players_positions, :class_name => 'PlayerFormationPosition'
  
  def self.create_from(data)
    players_positions = Array.new
    data.each do |item|
      element_value = item["formation"]["player"]
      x_value = item["formation"]["x"]
      y_value = item["formation"]["y"]
      
      player = Player.find(element_value.to_s)
      players_positions << PlayerFormationPosition.new(:player => player, :x => x_value, :y => y_value)
    end
    Formation.new :players_positions => players_positions
  end
  
end
