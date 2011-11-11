require 'spec_helper'

describe GlucoseReading do
  
  before(:each) do
    @user = Factory(:user)
    @glucose_reading = GlucoseReading.new({ glucose_value: 100, reading_at: Time.now, meal_code: 1, comment: 'Test Reading' })
    @glucose_reading.user_id = @user.id
  end
  
  it "should be valid with a user_id, glucose_alue, and reading_at" do
    @glucose_reading.should be_valid
  end
  
  it "should not allow mass assignment of user_id" do
    @glucose_reading.user_id = nil
    @glucose_reading.attributes = { user_id: 1 }
    @glucose_reading.should_not be_valid
  end
  
  it "should not be valid without a user_id" do
    @glucose_reading.user_id = nil
    @glucose_reading.should_not be_valid
  end
  
  it "should not be valid without a glucose_value" do
    @glucose_reading.glucose_value = nil
    @glucose_reading.should_not be_valid
  end
  
  it "should not be valid with a glucose_value <= 0" do
    @glucose_reading.glucose_value = -1
    @glucose_reading.should_not be_valid
  end
  
  it "should not be valid without a reading_at" do
    @glucose_reading.reading_at = nil
    @glucose_reading.should_not be_valid
  end
  
  it "should not be valid without a meal_code" do
    @glucose_reading.meal_code = nil
    @glucose_reading.should_not be_valid
  end
  
  it "should not be valid with a meal_code <= 0" do
    @glucose_reading.meal_code = -1
    @glucose_reading.should_not be_valid
  end
  
  it "should not be valid with a meal_code > 7" do
    @glucose_reading.meal_code = 8
    @glucose_reading.should_not be_valid
  end
  
  it "should have a an associated user" do
    @glucose_reading.save
    @glucose_reading.user.should == @user
  end
  
end# == Schema Information
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

