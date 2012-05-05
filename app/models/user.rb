class User
  include MongoMapper::Document
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  key :admin, Boolean
  key :nickname, String
  key :score, Integer
  key :image, String
  
  validates :nickname, :presence => true
  
  before_destroy :destroy_all_formations

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"]
        user.email = data["email"]
        user.image = data["image"]
      end
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    # data = access_token.extra.raw_info
    data = access_token.info
    if user = User.where(:email => data.email).first
      if data.image.present?    # update the user's image every time he logs in
        user.update_attribute(:image, data.image)        
      end
      user
    else # Create a user with a stub password. 
      User.create!(role: :plain, nickname: data.name, email: data.email, :image => data.image, 
                    password: Devise.friendly_token[0,20], confirmed_at: Time.now.utc) 
    end
  end
  
  def self.all_by_score
    all(:admin.ne => true, :confirmed_at.ne => true, :score.ne => true, :order => :score.desc)
  end
  
  def self.top_scorers_of(limit)
    all(:admin.ne => true, :confirmed_at.ne => true, :limit => limit, :order => :score.desc)
  end
  
  def owner_of?(formation)
    formation.owner_id == id
  end
  
  def formations
    Formation.all(owner_id: id, :order => :created_at.desc)
  end
  
  def image
    if admin?
      @image || "selecaoicone.png"
    else
      @image || "escudos/bahia.png"
    end
  end

private
  def destroy_all_formations
    formations.each { |f| f.destroy }
  end

end
