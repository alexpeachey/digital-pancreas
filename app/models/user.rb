class User < ActiveRecord::Base
  include DiabeticCalculator
  extend FriendlyId
  friendly_id :user_name
  attr_accessible :user_name, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, on: :create
  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates_format_of :user_name, with: /^[-\w]+$/i, message: "limited to letters, numbers, or -"
  has_many :glucose_readings, dependent: :destroy
  
  def user_name=(val)
    val.nil? ? write_attribute(:user_name,val) : write_attribute(:user_name,val.downcase)
  end
  
  def proper_name
    user_name.capitalize
  end
  
  def email=(val)
    val.nil? ? write_attribute(:email,val) : write_attribute(:email,val.downcase)
  end
  
  def method_missing(method_name,*args,&block)
    case method_name
    when /^average_(\w+)_level/ then
      average_level(add_measurement_to_args($1,args))
    when /^min_(\w+)_level/ then
      min_level(add_measurement_to_args($1,args))
    when /^max_(\w+)_level/ then
      max_level(add_measurement_to_args($1,args))
    else super method_name, *args, &block
    end
  end
  
  private
  def add_measurement_to_args(measurement,*args)
    args = Hash[*args.flatten]
    args[:measurement] = measurement.to_sym
    args
  end
  
end
# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  user_name       :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

