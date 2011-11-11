class User < ActiveRecord::Base
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
  
  def email=(val)
    val.nil? ? write_attribute(:email,val) : write_attribute(:email,val.downcase)
  end
  
  def average_glucose_level(*args)
    levels = valid_levels_for_args(args)
    levels.inject { |sum, r| sum + r }.to_f / levels.size
  end
  
  def min_glucose_level(*args)
    levels = valid_levels_for_args(args)
    levels.min
  end
  
  def max_glucose_level(*args)
    levels = valid_levels_for_args(args)
    levels.max
  end
  
  private
  def valid_levels_for_args(*args)
    args = Hash[*args.flatten]
    if args[:begin_date].present? && args[:end_date].present?
      levels = self.glucose_readings.between(args[:begin_date],args[:end_date]).map { |r| r.glucose_value }
    elsif args[:begin_date].present?
      levels ||= self.glucose_readings.between(args[:begin_date],Time.now).map { |r| r.glucose_value }
    elsif args[:n].present? 
      levels = self.glucose_readings.recent.limit(args[:n]).map { |r| r.glucose_value }
    elsif args[:meal_code].present?
      levels = self.glucose_readings.by_meal_code(args[:meal_code]).map { |r| r.glucose_value }
    else
      levels = self.glucose_readings.map { |r| r.glucose_value }
    end
    
    levels
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

