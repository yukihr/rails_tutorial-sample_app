require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "delete links" do
    let(:another_user) { FactoryGirl.create(:user) }
    before(:all) do
      10.times { FactoryGirl.create(:micropost, user: another_user, content: "Foooo") }
    end
    after(:all)  { Micropost.delete_all }

    before { visit user_path(another_user) }

    it "should not create delete link for not current user" do
      Micropost.paginate(page: 1).each do |mp|
        should_not have_link("delete", href: micropost_path(mp))
      end
    end
  end

end
