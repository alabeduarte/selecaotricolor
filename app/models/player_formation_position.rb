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
    if (position_mapper != nil && position_mapper.code != nil)
      position_mapper.code
    else
      ""
    end
  end
  
  private
  def position_mapper
    PositionMapper.first(:x_min.lte => x, :x_max.gte => x, :y_min.lte => y, :y_max.gte => y)
  end
  
end
