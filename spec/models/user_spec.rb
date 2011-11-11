require 'spec_helper'

describe User do
  
  before(:each) do
    @user = User.new({user_name: 'user1', email: 'user1@foo.com', password: 'password', password_confirmation: 'password'})
  end
  
  it "should be valid with a user_name, password, and matching password_confirmation" do
    @user.should be_valid
  end
  
  it "should not be valid without a user_name" do
    @user.user_name = nil
    @user.should_not be_valid
  end
  
  it "should not be valid without a password and confirmation" do
    @user.password = nil
    @user.password_confirmation = nil
    @user.should_not be_valid
  end
  
  it "should not be valid without a password and matching confirmation" do
    @user.password_confirmation = 'not_password'
    @user.should_not be_valid
  end
  
  it "should not be valid with illegal characters in the user_name" do
    @user.user_name = 'bad u$ser n()me'
    @user.should_not be_valid
  end
  
  it "should always have a lower case user_name" do
    @user.user_name = 'NameWithCaps'
    @user.user_name.should == @user.user_name.downcase
  end
  
  it "should always have a lower case email" do
    @user.email = "Name@Foo.com"
    @user.email.should == @user.email.downcase
  end
  
  it "should be findable by username using find()" do
    @user.save
    @u = User.find('user1')
    @user.id.should == @u.id
  end
  
  it "should have a collection of glucose_readings" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user)
    @r2 = Factory(:glucose_reading, user: @user)
    @user.glucose_readings.should include @r1
  end
  
  it "should have an average_glucose_level" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @user.average_glucose_level.should == 100
  end
  
  it "should have an average_glucose_level between two different dates" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 120, reading_at: Time.now - 5.days)
    @user.average_glucose_level(begin_date: Time.now - 1.day, end_date: Time.now).should == 100
  end
  
  it "should have an average_glucose_level since a specific date" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 120, reading_at: Time.now - 5.days)
    @user.average_glucose_level(begin_date: Time.now - 1.day).should == 100
  end
  
  it "should have an average_glucose_level for last n number of readings" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 120, reading_at: Time.now - 5.days)
    @user.average_glucose_level(n: 2).should == 100
  end
  
  it "should have an average_glucose_level for a specific meal_code" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, meal_code: 2, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, meal_code: 2, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, meal_code: 3, glucose_value: 120)
    @user.average_glucose_level(meal_code: 2).should == 100
  end
  
  it "should have an min_glucose_level" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @user.min_glucose_level.should == 90
  end
  
  it "should have an min_glucose_level between two different dates" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 70, reading_at: Time.now - 5.days)
    @user.min_glucose_level(begin_date: Time.now - 1.day, end_date: Time.now).should == 90
  end
  
  it "should have an min_glucose_level since a specific date" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 70, reading_at: Time.now - 5.days)
    @user.min_glucose_level(begin_date: Time.now - 1.day).should == 90
  end
  
  it "should have an min_glucose_level for last n number of readings" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 70, reading_at: Time.now - 5.days)
    @user.min_glucose_level(n: 2).should == 90
  end
  
  it "should have an min_glucose_level for a specific meal_code" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, meal_code: 2, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, meal_code: 2, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, meal_code: 3, glucose_value: 70)
    @user.min_glucose_level(meal_code: 2).should == 90
  end
  
  it "should have an max_glucose_level" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @user.max_glucose_level.should == 110
  end
  
  it "should have an max_glucose_level between two different dates" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 120, reading_at: Time.now - 5.days)
    @user.max_glucose_level(begin_date: Time.now - 1.day, end_date: Time.now).should == 110
  end
  
  it "should have an max_glucose_level since a specific date" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 120, reading_at: Time.now - 5.days)
    @user.max_glucose_level(begin_date: Time.now - 1.day).should == 110
  end
  
  it "should have an max_glucose_level for last n number of readings" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, glucose_value: 120, reading_at: Time.now - 5.days)
    @user.max_glucose_level(n: 2).should == 110
  end
  
  it "should have an max_glucose_level for a specific meal_code" do
    @user.save
    @r1 = Factory(:glucose_reading, user: @user, meal_code: 2, glucose_value: 90)
    @r2 = Factory(:glucose_reading, user: @user, meal_code: 2, glucose_value: 110)
    @r3 = Factory(:glucose_reading, user: @user, meal_code: 3, glucose_value: 120)
    @user.max_glucose_level(meal_code: 2).should == 110
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

