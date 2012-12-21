require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  before do
    @micropost = user.microposts.create(content: "Lorem ipsum")
    @comment = other_user.comments.build(content: "HugaHoge", micropost_id: @micropost.id)
  end

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:micropost_id) }
  it { should respond_to(:user_id) }
  its(:user) { should == other_user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @comment.user_id = nil }
    it { should_not be_valid }
  end

  describe "when micropost_id is not present" do
    before { @comment.micropost_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Comment.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
