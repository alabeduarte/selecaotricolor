class Scorer
  
  def initialize(args)
    @formations = args[:formations]
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
  
private
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