class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  def expire_cache(match=nil)
    expire_fragment(:controller => 'calendars', :action => 'formations_matches', :id => match)
  end
  
  def found_first_team?(first_team)
    first_team && first_team.formation && first_team.formation.players_ordered_by_positions && first_team.formation.match
  end
  
  def after_sign_in_path_for(resource)
    '/profile'
  end
  
end
