class Substitution
  include MongoMapper::EmbeddedDocument

  key :off_id, ObjectId
  key :on_id, ObjectId
  
  belongs_to :off, :class_name => 'Player'
  belongs_to :on, :class_name => 'Player'
  
  validates :off, :presence => true
  validates :on, :presence => true

end
