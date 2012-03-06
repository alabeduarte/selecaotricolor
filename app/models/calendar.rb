class Calendar
  include MongoMapper::Document
  
  plugin MongoMapper::Plugins::MultiParameterAttributes

  key :day, Time
  key :home_id, ObjectId
  key :away_id, ObjectId
  key :contains_formations, Boolean
  
  belongs_to :home, :class_name => 'Team'
  belongs_to :away, :class_name => 'Team'

  validates :day, :presence => true
  validates :home, :presence => true
  validates :away, :presence => true
  
  def self.next_match
    sort(:day).where(:day => {:$gte => Time.now}).first
  end
  
  def formations
    Formation.all(match_id: id, :order => :created_at.desc)
  end

end
