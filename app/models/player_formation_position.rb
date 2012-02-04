class PlayerFormationPosition
  include MongoMapper::Document
  
  key :player_id, ObjectId
  key :x, Integer
  key :y, Integer
  key :formation_id, ObjectId
  
  belongs_to :formation, :dependent => :destroy
  belongs_to :player
end
