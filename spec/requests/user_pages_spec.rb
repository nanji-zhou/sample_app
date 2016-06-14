require 'spec_helper'

describe "UserPages" do
  
  subject { page }

  describe "profile page" do
	let(:user) { FactoryGirl.create(:user) }
	before { visit user_path(user) }

	  #it { should have_content(user.name) }
    it "[4]should have the content of user name" do  
      expect(page).to have_content(user.name)
    end
	  
	#it { should have_title(user.name) }
	it "[3]should have the title of user name" do  
      expect(page).to have_title(user.name)
    end

  end
  
  describe "signup page" do
    before { visit signup_path }

    #it { should have_content('Sign up') }
	it "[2]should have the content 'Sign up'" do  
      expect(page).to have_content('Sign up')
    end
	
    #it { should have_title(full_title('Sign up')) }
    it "[1]should have title 'Sign up'" do  
      expect(page).to have_title(full_title('Sign up'))
    end
	
  end
  
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
	  
	  describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        
        it { should have_link('Sign out') }		
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
	  
	  describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end	
end
