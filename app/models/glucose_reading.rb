class GlucoseReading < ActiveRecord::Base
  attr_accessible :glucose, :reading_at, :meal_code, :comment
  validates_presence_of :user_id
  validates_numericality_of :glucose, greater_than: 0
  validates_presence_of :reading_at
  validates_numericality_of :meal_code
  validates_inclusion_of :meal_code, in: (1..8)
  belongs_to :user
  scope :between, lambda { |d1,d2| where('reading_at >= ? and reading_at <= ?',d1,d2) }
  scope :by_meal_code, lambda { |mc| where('meal_code = ?',mc) }
  scope :recent, order('reading_at desc')
  
  def meal_code_name
    case self.meal_code
    when 1 
      'Before Breakfast'
    when 2 
      'After Breakfast'
    when 3 
      'Before Lunch'
    when 4 
      'After Lunch'
    when 5 
      'Before Dinner'
    when 6 
      'After Dinner'
    when 7
      'Before Snack'
    when 8 
      'Before Bed'
    else
      'Undefined'
    end
  end
end

# == Schema Information
#
# Table name: glucose_readings
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  glucose    :integer
#  reading_at :datetime
#  comment    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  meal_code  :integer
#  bolus      :integer         default(0)
#  basal      :integer         default(0)
#  exercise   :integer         default(0)
#  carbs      :integer         default(0)
#

