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
  
  before_validation :validate_substitution_limit
  
  def self.total(first_team)
    Substitution.where(:first_team_id => first_team.id).count
  end
  
  def validate_substitution_limit
    raise I18n.t(:substitution_limit_overflow) if Substitution.total(self.first_team) >= 3    
  end

end
