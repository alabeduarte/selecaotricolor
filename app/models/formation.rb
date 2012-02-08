class Formation
  include MongoMapper::Document
  self.include_root_in_json = true
  
  key :team_id, ObjectId
  key :match_id, ObjectId
  key :created_at, Time
  
  belongs_to :team
  belongs_to :match, :class_name => 'Calendar', :dependent => :destroy
  many :players_positions, :class_name => 'PlayerFormationPosition'
  
  validates :team, :presence => true
  validates :match, :presence => true
  validates :created_at, :presence => true
  
  def self.create_from(data)
    players_positions = Array.new
    data.each do |item|
      element_value = item["formation"]["player"]
      x_value = item["formation"]["x"]
      y_value = item["formation"]["y"]
      
      player = Player.find(element_value.to_s)
      players_positions << PlayerFormationPosition.new(:player => player, :x => x_value, :y => y_value)
    end
    Formation.new(players_positions: players_positions, 
                  team: Team.bahia.first,
                  match: Calendar.next_match,
                  created_at: Time.now)
  end
  
end
