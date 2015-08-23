class User < ActiveRecord::Base
  
  #Run this before the email is saved, to make it all downcase
  #this is a "callback" --read more about this.
  before_save { self.email = email.downcase }
  
  validates :name,  presence: true, length: { maximum: 50 }
  
  #Regex (regular expression) to ensure valid format of email:
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false}
                    
  has_secure_password                  
  validates :password, length: { minimum: 6 }
  
  # Returns the hash digest of the given string.
  # re-visit this concept (8.2), 
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
                    
                    
end
