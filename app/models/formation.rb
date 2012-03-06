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
  
  def self.create_from(data, user)
    players_positions = Array.new
    data.each do |item|
      element_value = item["formation"]["player"]
      x_value = item["formation"]["x"]
      y_value = item["formation"]["y"]
      
      player = Player.find(element_value.to_s)
      players_positions << PlayerFormationPosition.new(player: player, x: x_value, y: y_value)
    end
    next_match = Calendar.next_match
    next_match.contains_formations = true
    next_match.save
    Formation.new(players_positions: players_positions, 
                  team: Team.bahia,
                  match: next_match,
                  created_at: Time.now,
                  owner: user)    
  end
  
  def self.newly_created(user)
    Formation.first(:owner_id => user.id, :order => :created_at.desc)
  end
  
  def save_all_players
    @players_positions.each do |position| position.save end
  end
  
  def players_ordered_by_positions
    PlayerFormationPosition.all(:formation_id => id, :order => :id.asc)
  end
  
  def tactical
    defenders = 0
    midfields = 0
    forwards = 0
    players_positions.each do |position| 
      if position.acronym[0] == 'D' 
        defenders += 1
      end
    end
    players_positions.each do |position| 
      if position.acronym[0] == 'M' 
        midfields += 1
      end
    end
    players_positions.each do |position| 
      if position.acronym[0] == 'A' 
        forwards += 1
      end
    end
    "#{defenders}-#{midfields}-#{forwards}"
  end
  
end
