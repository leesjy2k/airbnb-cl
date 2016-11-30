class User < ActiveRecord::Base
  include Clearance::User
mount_uploader :avatar, AvatarUploader
    
  	has_many :listings, :dependent => :destroy
    has_many :authentications, :dependent => :destroy
    has_many :reservations
    validates :email, uniqueness: true, presence: true
    enum role: {tenant: 0, host: 1, admin: 2}
  
  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.name = auth_hash["info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
end
