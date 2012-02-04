class Formation
  include MongoMapper::Document
  self.include_root_in_json = true
  
  key :team_id, ObjectId
  key :calendar_id, ObjectId
  
  belongs_to :team
  belongs_to :calendar
  many :players_positions, :class_name => 'PlayerFormationPosition', :dependent => :destroy
  
  validates :team, :presence => true
  validates :calendar, :presence => true
  
  def self.create_from(data)
    players_positions = Array.new
    data.each do |item|
      element_value = item["formation"]["player"]
      x_value = item["formation"]["x"]
      y_value = item["formation"]["y"]
      
      player = Player.find(element_value.to_s)
      players_positions << PlayerFormationPosition.new(:player => player, :x => x_value, :y => y_value)
    end
    Formation.new :players_positions => players_positions
  end
  
end
