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

  before_destroy :destroy_all_formations

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
    @formations ||= Formation.of_match(self).all
  end

  def next?
    id == Calendar.next_match.id
  end

  def last?
    id == Calendar.last_match.id
  end

  def oldest?
    @day <= Calendar.last_match.day
  end

  def expired?
    Time.now.utc + 2.hour > @day.utc
  end

private
  def destroy_all_formations
    formations.each { |f| f.destroy }
  end

end
