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
                    
                    
end
