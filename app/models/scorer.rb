class Scorer
  
  attr_accessor :first_team
  
  def initialize(args)
    @formations = args[:formations]
    @first_team = args[:first_team]
    @match = args[:match]
  end
  
  def add(args)
    score = args[:score]
    winners = args[:to]
    winners.each do |w|
      if (w.score)
        w.score += score
      else
        w.score = score
      end
      w.save
    end
  end
  
  def add_by_predict_player(bonus)         
    @match.formations.each do |f|
      correct_count = 0
      @first_team.formation.players_positions.each do |real_position|
        f.players_positions.each do |position|
          if (real_position.player.id == position.player.id)
            correct_count += 1
          end
        end
      end
      if !f.owner.admin?
        winners = Array.new
        winners << f.owner
        self.add(score: (correct_count * bonus), to: winners)
      end
    end
  end
  
  def winners
    winners = Array.new
    @match.formations.each { |f| winners << f.owner unless f.owner.admin? }
    return winners.uniq
  end
  
  def squad_winners
    winners = Array.new        
    @match.formations.each do |f|
      correct_count = 0
      @first_team.formation.players_positions.each do |real_position|
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
  
  def tactical_most_voted
    max = 1
    tactical = nil
    tactical_group.each do |key, value|
      if max <= value.size
        max = value.size
        tactical = key
      end
    end
    return tactical
  end
  
  def formations_by(tactical)
    group = tactical_group
    group.fetch(tactical) if group.has_key? tactical
  end

protected
  def tactical_group
    hash = Hash.new    
    @formations.each do |formation|    
      if hash.has_key? formation.tactical
        list = hash.fetch(formation.tactical)        
      else
        list = Array.new
      end
      list << formation
      hash.store(formation.tactical, list)      
    end
    return hash
  end
  
end