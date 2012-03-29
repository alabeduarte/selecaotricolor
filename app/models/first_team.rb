class FirstTeam
  include MongoMapper::Document

  key :formation_id, ObjectId
  belongs_to :formation
  validates :formation, :presence => true

  def self.create_from(args)
    args[:match] = args[:match] || Calendar.last_match
    formation = Formation.create_from(args)
    FirstTeam.create!(formation: formation)
  end

end
