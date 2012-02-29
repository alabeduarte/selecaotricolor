class Player
  include MongoMapper::Document
  self.include_root_in_json = true
  
  many :positions, :class_name => 'PlayerFormationPosition', :dependent => :destroy
  
  key :name, String
  key :number, Integer
  key :team_id, ObjectId
  key :position_mapper_id, ObjectId
  key :enabled, Boolean
  
  belongs_to :team
  belongs_to :position_mapper
  
  validates :name, :presence => true
  validates :number, :presence => true, :numericality => true, :length => {:minimum => 1, :maximum => 2}
  validates :team, :presence => true
  
  def self.players_of(team)
    Player.all(:team_id => team.id, :order => :position_mapper_id.desc)
  end
  
  def self.disabled_players_names_of(team)
    disabled_players = Player.all(:team_id => team.id, :enabled => false, :order => :position_mapper_id.desc)
    names = Array.new
    disabled_players.each do |d| names << d.name end
    names
  end
  
end
