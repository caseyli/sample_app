require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector('title', 
                                    :content => @base_title + " | Home")
    end
    
    describe "for signed-in users" do
    
      before(:each) do
        @user = test_sign_in(Factory(:user))
        
        sample_mp1 = [Factory(:micropost, :user => @user, :content => "hello")]
        sample_mp2 = [Factory(:micropost, :user => @user, :content => "hello")]
        @feed_items = [sample_mp1, sample_mp2]
        80.times do
           @feed_items << Factory(:micropost, :user => @user, :content => "hello")
        end
      end
    
      it "should have the right number of posts in the sidebar" do
        get 'home'
        response.should have_selector('span.microposts',
                                      :content => @user.microposts.count.to_s + " micropost")
      end
      
      it "should be pluralized properly for single post" do
        mp1 = Factory(:micropost, :user => @user, :content => "hello")
        get 'home'
        response.should have_selector('span.microposts',
                                      :content => @user.microposts.count.to_s + " micropost")
      end
      
      it "should be pluralized properly for multiple posts" do
        mp1 = Factory(:micropost, :user => @user, :content => "hello")
        mp2 = Factory(:micropost, :user => @user, :content => "hello2")
        get 'home'
        response.should have_selector('span.microposts',
                                      :content => @user.microposts.count.to_s + " microposts")
      end
      
      it "should paginate microposts" do
        get 'home'
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/?page=2",
                                           :content => "2")
        response.should have_selector("a", :href => "/?page=2",
                                           :content => "Next")
      end
      
      it "should not show delete links beside posts not created by user" do
        get 'home'
        # I really don't know how I would test for this?
        # Perhaps iterate through table?
        
      end
      
    end
    
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector('title', 
                                    :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector('title', 
                                    :content => @base_title + " | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector('title', :content => "Ruby on Rails Tutorial Sample App | Help")
    end
  end

end
