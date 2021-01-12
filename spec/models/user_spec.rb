require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it "should pass if all validations meet" do
      @user = User.new({:password => "hello", :password_confirmation => "hello", :email => "1@1", :first_name => "bob", :last_name => "jones"})
      expect(@user.save).to eq(true)
    end

    it "should not pass if password is not present" do
      @user = User.new({:password => nil, :password_confirmation => "hell0", :email => "1@1", :first_name => "bob", :last_name => "jones"})
      expect(@user.save).to eq(false)
    end
    
    it "should not pass if email is not present" do
      @user = User.new({:password => "hell0", :password_confirmation => "hell0", :email => nil, :first_name => "bob", :last_name => "jones"})
      expect(@user.save).to eq(false)
    end
    
    it "should not pass if first name is not present" do
      @user = User.new({:password => "hell0", :password_confirmation => "hell0", :email => "1@1", :first_name => nil, :last_name => "jones"})
      expect(@user.save).to eq(false)
    end
    
    it "should not pass if last name is not present" do
      @user = User.new({:password => "hell0", :password_confirmation => "hell0", :email => "1@1", :first_name => "bob", :last_name => nil})
      expect(@user.save).to eq(false)
    end
    
    it "should not pass if passwords dont match" do
      @user = User.new({:password => "hello", :password_confirmation => "hell0", :email => "1@1", :first_name => "bob", :last_name => "jones"})
      expect(@user.save).to eq(false)
    end

    it "should not pass if emails are not unique" do
      @user1 = User.new({:password => "hell0", :password_confirmation => "hell0", :email => "hello@world.com", :first_name => "bob", :last_name => "jones"})
      @user1.save
      @user2 = User.new({:password => "world", :password_confirmation => "world", :email => "HeLLO@WorLd.com", :first_name => "jack", :last_name => "jones"})
      expect(@user1.save).to eq(true)
      expect(@user2.save).to eq(false)
    end

    it "should not pass if password is lss than 5 chars" do
      @user = User.new({:password => 'heee', :password_confirmation => "heee", :email => "1@1", :first_name => "bob", :last_name => "jones"})
      expect(@user.save).to eq(false)
    end
  
  end 

  describe '.authenticate_with_credentials' do
    
    it "should validate a user if the case on email is wrong" do
      @user = User.new({:password => 'heeee', :password_confirmation => "heeee", :email => "example@gmail.com", :first_name => "bob", :last_name => "jones"})
      user = User.find_by_email("ExamPLE@gmaiL.COM".downcase.strip)
      expect(user).to eq(User.authenticate_with_credentials("ExamPLE@gmaiL.COM", "heeee"))
    end

    it "should validate a user if the spacing on email is wrong" do
      @user = User.new({:password => 'heeee', :password_confirmation => "heeee", :email => "example@gmail.com", :first_name => "bob", :last_name => "jones"})
      user = User.find_by_email("     ExamPLE@gmaiL.COM ".downcase.strip)
      expect(user).to eq(User.authenticate_with_credentials("       ExamPLE@gmaiL.COM      ", "heeee"))
    end
  end
end
