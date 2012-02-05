class PlayerFormationPosition
  include MongoMapper::Document
  
  key :player_id, ObjectId
  key :x, Integer
  key :y, Integer
  key :formation_id, ObjectId
  
  belongs_to :formation, :dependent => :destroy
  belongs_to :player
  
  def position_mapper
    PositionMapper.first(:x_min.lte => x, :x_max.gte => x, :y_min.lte => y, :y_max.gte => y)
  end
  
end
