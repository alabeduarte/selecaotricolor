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
  
  def to_s
    "#{home.name} x #{away.name}"
  end
  
  def self.next_match
    sort(:day).where(:day => {:$gte => Time.now}).first
  end
  
  def self.last_match
    sort(:day.desc).where(:day => {:$lt => Time.now}).first
  end
  
  def self.with_tactics
    all(contains_formations: true, :order => :day.desc)
  end
  
  def formations
    Formation.all(match_id: id, :order => :created_at.desc)
  end
  
  def next?
    id == Calendar.next_match.id
  end
  
  def last?
    id == Calendar.last_match.id
  end
  
  def oldest?
    if @day <= Calendar.last_match.day
      return true
    end
    return false
  end
  
  def tactical_most_voted
    Scorer.new(formations: formations).tactical_most_voted    
  end

end
