require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is wrong!
    @micropost = user.microposts.build(content: "Lorem ipsum")
  end

  subject { @micropost }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end

  describe "comment associations" do
    before { @micropost.save }
    let!(:older_comment) do
      FactoryGirl.create(:comment, user:user, micropost:@micropost, created_at: 1.day.ago)
    end
    let!(:newer_comment) do
      FactoryGirl.create(:comment, user:user, micropost:@micropost, created_at: 1.hour.ago)
    end

    it "should have the right comment in the right order" do
      @micropost.comments.should == [older_comment, newer_comment]
    end

    it "should destroy associated comments" do
      comments = @micropost.comments.dup
      @micropost.destroy
      comments.should_not be_empty
      comments.each do |comment|
        Comment.find_by_id(comment.id).should be_nil
      end
    end
  end
end
