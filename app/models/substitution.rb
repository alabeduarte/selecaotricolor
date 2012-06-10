class Substitution
  include MongoMapper::Document

  key :first_team_id, ObjectId
  key :off_id, ObjectId
  key :on_id, ObjectId
  
  belongs_to :first_team
  belongs_to :off, :class_name => 'Player'
  belongs_to :on, :class_name => 'Player'
  
  validates :first_team, :presence => true
  validates :off, :presence => true
  validates :on, :presence => true

end
