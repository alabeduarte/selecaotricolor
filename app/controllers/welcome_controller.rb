class WelcomeController < ApplicationController
  def index
    @users = User.top_scorers_of 5
  end
end
