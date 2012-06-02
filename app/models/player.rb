class Player
  include MongoMapper::Document
  self.include_root_in_json = true
  
  many :positions, :class_name => 'PlayerFormationPosition', :dependent => :destroy
  
  key :name, String
  key :number, Integer
  key :team_id, ObjectId
  key :position_mapper_id, ObjectId
  key :enabled, Boolean
  key :rating, Integer
  
  belongs_to :team
  belongs_to :position_mapper
  
  validates :name, :presence => true
  validates :number, :presence => true, :numericality => true, :length => {:minimum => 1, :maximum => 2}
  validates :team, :presence => true
  
  def self.players_of(team)
    Player.sort(:position_mapper_id.asc, :rating.desc).where(:team_id => team.id)
  end
  
  def increase_rating
    self.rating ||= 0
    self.update_attributes(rating: self.rating + 1)
  end
  
  def decrease_rating
    self.rating ||= 0
    self.update_attributes(rating: self.rating - 1) if self.rating > 0
  end
  
end
