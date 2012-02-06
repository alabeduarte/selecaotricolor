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
  
  def next_match
    Calendar.next_match.first
  end
  
end
