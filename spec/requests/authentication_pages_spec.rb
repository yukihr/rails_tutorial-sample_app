require 'spec_helper'

describe "Authentication" do
  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    it { should have_selector('title', text: user.name) }
    it { should have_link('Profile',  href: user_path(user)) }
    it { should have_link('Settings', href: edit_user_path(user)) }
    it { should have_link('Sign out', href: signout_path) }
    it { should_not have_link('Sign in', href: signin_path) }
  end
end
