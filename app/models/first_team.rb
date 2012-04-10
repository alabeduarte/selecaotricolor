class FirstTeam
  include MongoMapper::Document

  key :formation_id, ObjectId
  belongs_to :formation
  validates :formation, :presence => true
  
  def apply_score(scorer)
    @scorer = scorer
    @scorer.first_team = self
    self.apply_score_to_all_users
    self.apply_score_to_predict_users
  end
  
protected
  def apply_score_to_all_users
    winners = @scorer.winners
    @scorer.add(score: 1000, to: winners)
  end
  
  def apply_score_to_predict_users
    winners = @scorer.squad_winners
    @scorer.add(score: 5000, to: winners)
  end

end
