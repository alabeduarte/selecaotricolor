class PlayerFormationPosition
  include MongoMapper::Document
  
  key :player_id, ObjectId
  key :x, Integer
  key :y, Integer
  key :formation_id, ObjectId
  key :to_score, Boolean
  
  belongs_to :formation, :dependent => :destroy
  belongs_to :player
  
  def description
    position_mapper.description
  end
  
  def acronym
    position_mapper.code || "" if (position_mapper && position_mapper.code)
  end

  def self.mapping_positions(data)
    players_positions = Array.new
    data.each do |item|
      element_value = item["formation"]["player"]
      x_value = item["formation"]["x"]
      y_value = item["formation"]["y"]
      players_positions << self.new(player_id: element_value, x: x_value, y: y_value)
    end
    players_positions
  end
  
private
  def position_mapper
    PositionMapper.first(:x_min.lte => x, :x_max.gte => x, :y_min.lte => y, :y_max.gte => y)
  end
  
end
