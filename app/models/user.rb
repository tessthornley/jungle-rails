class User < ActiveRecord::Base

  has_secure_password
  has_many :reviews

  validates_associated :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :password_digest, presence: true
  validates :password, presence: true, :length => { :minimum => 4}
  validates :password_confirmation, presence: true

  scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase).first }

  def self.authenticate_with_credentials(email, password)
    user_email = email.strip
    @user = self.ci_find('email', user_email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
  
end
