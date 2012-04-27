class Calendar::Helper
  
  def init_oldest_match(home, away)
    Calendar.create!(
                      day: Time.utc(2000, 1, 1, 16, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: true)
  end
  
  def init_last_match(home, away)
    Calendar.create!(
                      day: Time.utc(2000, 1, 1, 17, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: true)
  end
  
  def init_next_match(home, away)
    Calendar.create!(
                      day: Time.utc(3000, 1, 1, 17, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: false)
  end
  
end