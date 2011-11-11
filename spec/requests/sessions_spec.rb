require 'spec_helper'

describe "Sessions" do
  
  describe "POST /sessions" do
    it "should sign the user in" do
      @user = Factory(:user)
      visit sign_in_path
      fill_in "User name", with: @user.user_name
      fill_in "Password", with: "password"
      click_button "Sign In"
      page.should have_content("Signed In")
    end
  end
  
  describe "DELETE /session" do
    it "should sign the user out" do
      @user = Factory(:user)
      visit sign_in_path
      fill_in "User name", with: @user.user_name
      fill_in "Password", with: "password"
      click_button "Sign In"
      visit sign_out_path
      page.should have_content("Sign In")
    end
  end
  
end