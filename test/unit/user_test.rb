require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @one_user = User.new :email => "one@xmail.com", :password => "secret"
    @one_user.save
  end

  test "should be valid user" do
  	some_user = User.new :email => "some_user@xmail.com", :password => "secret"
    assert some_user.valid?
  end
  
  test "password must be present" do
    some_user = User.new :email => "test@xmail.com"
    assert some_user.invalid?, "Missing password"
  end

  test "user should be invalid with email" do
  	some_user = User.new :email => "one" 
  	assert some_user.invalid?
  end
  
  test "find user by email" do
    exist_user = User.find_by_email("one@xmail.com")
    assert_equal exist_user.email, @one_user.email
  end
  
  test "email cannot be blank" do
  	some_user = User.new
  	assert some_user.invalid?
  end
  
  test "email must be unique" do
    user = User.new :email => "one@xmail.com"
    assert_raise MongoMapper::DocumentNotValid do
      user.save!
    end
  end
  
  test "should authenticate user by email and password" do
    some_user = User.create(:email => "test@xmail.com", :password => "secret")
    user = User.authenticate("test@xmail.com", "secret")
    assert_not_nil user
  end
  
  test "password should be init blank" do
    some_user = User.new
    assert some_user.password.blank?
  end

end
