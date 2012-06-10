class FirstTeam
  include MongoMapper::Document

  key :formation_id, ObjectId
  belongs_to :formation
  many :substitutions
  
  validates :formation, :presence => true
  validates :substitutions, :length => { :maximum => 3 }
  
  def apply_score(scorer)
    @scorer = scorer
    @scorer.first_team = self
    self.apply_score_to_all_users
    self.apply_score_to_predict_users
  end
  
  def self.last_of_the_round
    FirstTeam.sort(:id.desc).first
  end
  
  def self.all_by_match
    FirstTeam.sort(:id.desc).all
  end
  
  def squad_winners_of_the_round
    match = formation.match
    Scorer.new(first_team: self, match: match).squad_winners
  end
  
  def match
    self.formation.match.to_s
  end
  
  def has_replaced?(player)
    substitution(player)? true: false
  end
  
  def substitution(player)
    self.substitutions.each do |sub|
      if sub.off == player
        return sub
      end
    end
    return nil
  end
 
protected
  def apply_score_to_all_users
    winners = @scorer.winners
    @scorer.add(score: 100, to: winners)
  end
  
  def apply_score_to_predict_users
    winners = @scorer.winners
    @scorer.add_by_predict_player(10)
    squad_winners = @scorer.squad_winners
    @scorer.add(score: 40, to: squad_winners)
  end

end
