require 'spec_helper'

describe "GlucoseReadings" do
  
  describe "GET /glucose_readings" do
    it "should display a list of readings for the user" do
      @user = Factory(:user)
      @r1 = Factory(:glucose_reading, user: @user)
      @r2 = Factory(:glucose_reading, user: @user)
      visit sign_in_path
      fill_in "User name", with: @user.user_name
      fill_in "Password", with: "password"
      click_button "Sign In"
      visit glucose_readings_path
      page.should have_content(@user.user_name)
      page.should have_content(@r1.glucose_value)
      page.should have_content(@r2.glucose_value)
    end
  end
  
  describe "POST /glucose_readings" do
    it "should create a glucose reading" do
      @user = Factory(:user)
      visit sign_in_path
      fill_in "User name", with: @user.user_name
      fill_in "Password", with: "password"
      click_button "Sign In"
      visit new_glucose_reading_path
      fill_in "Glucose value", with: 120
      select '2', from: 'Meal code'
      fill_in "Comment", with: 'Test Reading'
      click_button "Log Reading"
      page.should have_content("Glucose Reading Logged")
      page.should have_content('120')
    end
  end
  
  describe "PUT /glucose_readings" do
    it "should update a glucose reading" do
      @user = Factory(:user)
      @r1 = Factory(:glucose_reading, user: @user)
      visit sign_in_path
      fill_in "User name", with: @user.user_name
      fill_in "Password", with: "password"
      click_button "Sign In"
      visit edit_glucose_reading_path @r1
      fill_in "Glucose value", with: 110
      click_button "Log Reading"
      page.should have_content("Glucose Reading Updated")
      page.should have_content('110')
    end
  end
  
  describe "DELETE /glucose_readings" do
    it "should delete a glucose reading" do
      @user = Factory(:user)
      @r1 = Factory(:glucose_reading, user: @user, glucose_value: 120)
      visit sign_in_path
      fill_in "User name", with: @user.user_name
      fill_in "Password", with: "password"
      click_button "Sign In"
      visit glucose_readings_path
      click_link "Destroy"
      page.should have_content("Glucose Reading Deleted")
      page.should_not have_content('120')
    end
  end
  
end