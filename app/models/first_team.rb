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
    self.apply_score_to_predict_users
  end

  def self.last_of_the_round
    FirstTeam.sort(:id.desc).first
  end

  def self.all_by_match
    FirstTeam.sort(:id.desc).all
  end

  def squad_winners
    winners = Array.new
    match = self.formation.match
    match.formations.each do |f|
      correct_count = 0
      formation.players_positions.each do |real_position|
        f.players_positions.each do |position|
          if (real_position.player.id == position.player.id)
            correct_count += 1
          end
        end
      end
      winners << f.owner unless f.owner.admin? if correct_count == 11
    end
    return winners.uniq
  end

  def tipsters
    tipsters = Array.new
    match = self.formation.match
    match.formations.each { |f| tipsters << f.owner unless f.owner.admin? }
    return tipsters.uniq
  end

  def match
    self.formation.match.to_s
  end

  def has_replaced?(player)
    substitution(player)? true: false
  end

  def substitution(player)
    @cache ||= Hash.new
    if @cache.has_key?(player)
      return @cache.fetch(player)
    else
      self.substitutions.each do |sub|
        if sub.off == player
          @cache[player] = sub
          return sub
        end
      end
    end
    return nil
  end

  def predicted_score
    (tipsters.size > 0 && squad_winners.size > 0)? (tipsters.size * 50 / squad_winners.size): 0
  end

  protected
  def apply_score_to_predict_users
    @scorer.add_by_predict_player(10)
    @scorer.add(score: predicted_score, to: squad_winners) if predicted_score > 0
  end
end
