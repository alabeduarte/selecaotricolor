module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @current_user = Factory.create(:admin)
      sign_in @current_user
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = Factory.create(:user)
      sign_in @current_user
    end
  end
end