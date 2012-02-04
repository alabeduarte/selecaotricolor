class Team
  include MongoMapper::Document
  
  key :name, String
  many :players
  many :calendars
  
  validates :name, :presence => true, :uniqueness => true
  
end
