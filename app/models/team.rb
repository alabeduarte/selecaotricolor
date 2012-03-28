require 'util/extend_string'
class Team
  include MongoMapper::Document
  
  key :name, String
  many :players
  many :calendars
  
  validates :name, :presence => true, :uniqueness => true
  
  def self.bahia
    where(name: 'Bahia').first
  end
  
  def label
    @name.downcase.strip.gsub(" ", "").removeaccents
  end
  
end
