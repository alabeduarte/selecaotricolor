class PlayerSweeper < ActionController::Caching::Sweeper
  observe Player
  
  def after_save(player)
    expire_cache(player)
  end
  
  def after_destroy(player)
    expire_cache(player)
  end

private 
  def expire_cache(player)
    p "OPA!!"
    expire_action :controller => 'player', :action => 'bahia_squad'
  end
end