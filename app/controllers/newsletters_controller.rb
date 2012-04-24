class NewslettersController < ApplicationController
  authorize_resource :class => false
  before_filter :authenticate_user!
  
  respond_to :json, :html
  
  def index
    @emails = Newsletter.all(User.all_by_score)
  end
end
