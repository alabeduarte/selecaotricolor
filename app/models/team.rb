class Team
  include MongoMapper::Document
  
  key :name, String
  many :players
  
  attr_accessible :name
  
end
