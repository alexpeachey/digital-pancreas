class GlucoseReading < ActiveRecord::Base
  attr_accessible :glucose_value, :reading_at, :meal_code, :comment
  validates_presence_of :user_id
  validates_numericality_of :glucose_value, greater_than: 0
  validates_presence_of :reading_at
  validates_numericality_of :meal_code
  validates_inclusion_of :meal_code, in: (1..7)
  belongs_to :user
  scope :between, lambda { |d1,d2| where('reading_at >= ? and reading_at <= ?',d1,d2) }
  scope :by_meal_code, lambda { |mc| where('meal_code = ?',mc) }
  scope :recent, order('reading_at desc')
end
# == Schema Information
#
# Table name: glucose_readings
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  glucose_value :integer
#  reading_at    :datetime
#  comment       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  meal_code     :integer
#

