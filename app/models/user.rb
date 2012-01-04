class User
  include MongoMapper::Document

  key :name, String
  key :email, String
  key :hashed_password, String
  key :salt, String

  validates :email, 
	          :uniqueness => true,
	          :presence => true,
	          :format => { 
	                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, 
	                      :message => "Invalid email" }
	                      
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password
  
  validate  :password_must_be_present
  
  class << self
    
    def authenticate(email, password)
      Authenticator.new(self).authenticate(email, password)
    end
    
  end
  
  # 'password' is a virtual attribute
  def password=(password) 
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = Authenticator.encrypt_password(password, salt)
    end 
  end
  
  private
    def password_must_be_present
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
    
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

end
