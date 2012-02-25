module ApplicationHelper
  
  # Shows link with style "current" in case when the target controller is same as 
  # current.
  def menu_link_to(title, options = {}, html_options = {})
    if current_page?(options)
      html_options[:class] ||= []
      html_options[:class] << "active"
    end

    link_to(title, options, html_options)
  end
  
  def current_uri
    "#{request.host}#{request.fullpath}"
  end
  
  def next_match
    Calendar.next_match
  end
  
  def current_user_owner_of?(formation)
    current_user.owner_of? formation unless !user_signed_in?
  end
  
end
