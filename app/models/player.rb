class Player
  include MongoMapper::Document
  
  key :name, String
  key :number, Integer
  key :team_id, ObjectId
  
  belongs_to :team
  
  validates :name, :presence => true
  validates :number, :presence => true, :numericality => true, :length => {:minimum => 1, :maximum => 2}
  validates :team, :presence => true
  
end
