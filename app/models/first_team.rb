class FirstTeam
  include MongoMapper::Document

  key :formation_id, ObjectId
  belongs_to :formation
  validates :formation, :presence => true
  
  # before_save :do_something_before_save  
  def apply_score(scorer)
    @scorer = scorer
    @scorer.first_team = self
    self.apply_score_to_all_users
    self.apply_score_to_predict_users
  end
  
  def self.last_of_the_round
    FirstTeam.sort(:id.desc).first
  end
  
  def squad_winners_of_the_round(match)
    Scorer.new(first_team: self, match: match).squad_winners
  end
 
protected
  def apply_score_to_all_users
    winners = @scorer.winners
    @scorer.add(score: 100, to: winners)
  end
  
  def apply_score_to_predict_users
    winners = @scorer.squad_winners
    @scorer.add(score: 300, to: winners)
  end

end
