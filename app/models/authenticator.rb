require 'digest/sha2'

class Authenticator
  
  def initialize(user)
    @user = user
  end
  
  def authenticate(email, password)
    if @user = User.find_by_email(email)
      if @user.hashed_password == self.class.encrypt_password(password, @user.salt)
        @user
      end 
    end
  end

  def self.encrypt_password(password, salt) 
    Digest::SHA2.hexdigest("#{password}wibble#{salt}")
  end
  
end
