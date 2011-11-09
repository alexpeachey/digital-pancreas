class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :user_name
  attr_accessible :user_name, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates_format_of :user_name, :with => /^[-\w]+$/i, :message => "limited to letters, numbers, or -"
  
  def user_name=(val)
    val.nil? ? write_attribute(:user_name,val) : write_attribute(:user_name,val.downcase)
  end
  
  def email=(val)
    val.nil? ? write_attribute(:email,val) : write_attribute(:email,val.downcase)
  end
end
