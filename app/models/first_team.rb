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
  
  def apply_score_to_all_users
    scorer = Scorer.new(match: formation.match)
    winners = scorer.winners
    scorer.add(score: 1000, to: winners)
  end
  
  def apply_score_to_predict_users
    scorer = Scorer.new(match: formation.match, first_team: self)
    winners = scorer.squad_winners
    scorer.add(score: 5000, to: winners)
  end

end
