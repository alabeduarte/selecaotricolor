class Player
  include MongoMapper::Document
  self.include_root_in_json = true
  
  many :positions, :class_name => 'PlayerFormationPosition', :dependent => :destroy
  
  key :name, String
  key :number, Integer
  key :team_id, ObjectId
  key :position_mapper_id, ObjectId
  
  belongs_to :team
  belongs_to :position_mapper
  
  validates :name, :presence => true
  validates :number, :presence => true, :numericality => true, :length => {:minimum => 1, :maximum => 2}
  validates :team, :presence => true
  
end
