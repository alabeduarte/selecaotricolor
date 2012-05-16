class Formation
  include MongoMapper::Document
  self.include_root_in_json = true
  
  key :team_id, ObjectId
  key :match_id, ObjectId
  key :created_at, Time
  key :owner_id, ObjectId
  
  belongs_to :team
  belongs_to :match, :class_name => 'Calendar', :dependent => :destroy
  belongs_to :owner, :class_name => 'User', :dependent => :destroy
  many :players_positions, :class_name => 'PlayerFormationPosition'
  
  validates :team, :presence => true
  validates :match, :presence => true
  validates :created_at, :presence => true
  validates :owner, :presence => true
  
  scope :of_match, lambda { |match| where(:match_id => match.id, :order => :created_at.desc) }
  
  before_validation :verify_if_once_per_match_and_per_user
  after_save :checkin_the_match
  before_destroy :destroy_all_positions
  
  def self.new_by(args)
    data = args[:data]
    owner = args[:owner]
    current_match = args[:match] || Calendar.next_match
    players_positions = PlayerFormationPosition.mapping_positions(data)
    self.new(
              players_positions: players_positions, 
              team: Team.bahia,
              match: current_match,
              created_at: Time.now,
              owner: owner)    
  end
  
  def self.newly_created(user)
    Formation.first(:owner_id => user.id, :order => :created_at.desc)
  end
  
  def self.already_created?(owner, match)
    Formation.first(:owner_id => owner.id, :match_id => match.id)
  end
  
  def self.time_is_over?(match)
    match.expired? if match.today?
  end
  
  def players_ordered_by_positions
    @players_ordered_by_positions ||= PlayerFormationPosition.all(:formation_id => id, :order => :id.asc)
  end
  
  def tactical
    defenders = 0
    midfields = 0
    forwards = 0
    players_positions.each do |position| 
      if position.acronym[0] == 'D' 
        defenders += 1
      end
      if position.acronym[0] == 'M' 
        midfields += 1
      end
      if position.acronym[0] == 'A' 
        forwards += 1
      end
    end
    "#{defenders}-#{midfields}-#{forwards}"
  end
  
protected
  def verify_if_once_per_match_and_per_user
    raise I18n.t(:formation_once_per_match) if Formation.already_created?(self.owner, self.match)    
  end
  
  def checkin_the_match
    current_match = @match || Calendar.next_match
    if current_match
      if !current_match.contains_formations?
        current_match.contains_formations = true
        current_match.save
      end
    end
  end
  
  def destroy_all_positions
    players_positions.each { |p| p.destroy }
  end
  
end
