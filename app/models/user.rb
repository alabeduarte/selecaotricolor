class User
  include MongoMapper::Document
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  key :admin, Boolean
  key :nickname, String
  validates :nickname, :presence => true

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      User.create!(role: :plain, nickname: data.name, email: data.email, 
                    password: Devise.friendly_token[0,20], confirmed_at: Time.now.utc) 
    end
  end
  
  def owner_of?(formation)
    formation.owner_id == id
  end
  
  def formations
    Formation.all(owner_id: id, :order => :created_at.desc)
  end

end
