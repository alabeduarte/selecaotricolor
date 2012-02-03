class Calendar
  include MongoMapper::Document

  key :day, DateTime
  key :home_id, ObjectId
  key :away_id, ObjectId
  
  belongs_to :home, :class_name => 'Team'
  belongs_to :away, :class_name => 'Team'

  validates :day, :presence => true
  validates :home, :presence => true
  validates :away, :presence => true

end
