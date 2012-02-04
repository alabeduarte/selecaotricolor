class Team
  include MongoMapper::Document
  
  key :name, String
  many :players
  
  validates :name, :presence => true, :uniqueness => true
  
end
