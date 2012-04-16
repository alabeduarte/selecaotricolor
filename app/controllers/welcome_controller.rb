class WelcomeController < ApplicationController
  caches_action :index, :expires_in => 1.hour
  def index
    @users = User.top_scorers_of 5
  end
end
