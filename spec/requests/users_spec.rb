require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "should return a 404" do
      get users_path
      response.response_code.should == 404
    end
  end
end
