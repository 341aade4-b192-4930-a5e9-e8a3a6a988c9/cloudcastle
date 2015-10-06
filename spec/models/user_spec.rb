require 'spec_helper'

describe User do
  let(:request) { FactoryGirl.build(:user) }
  before { @user = User.new(name: "Example", rating1: 1, rating2: 2) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:rating1) }
  it { should respond_to(:rating2) }

  it "should give correct raitings and status" do
    stub_request(:get, /followers/).
      to_return(:status => 200, :body => '[ { "login": "follower1", "id": 1 }, { "login": "follower2", "id": 2 } ]', :headers => {})

    stub_request(:get, /repos/).
      to_return(:status => 200, :body => '[ { "id": 1, "forks": 8,"watchers": 5 }, { "id": 1, "forks": 8,"watchers": 5 } ]', :headers => {})

    @user.execute

    @user.rating1.should be 12
    @user.rating2.should be 16

    @user.completed?.should be true
  end

  it "should give wrong status" do
    stub_request(:get, /followers/).
      to_return(:status => 200, :body => "error", :headers => {})

    stub_request(:get, /repos/).
      to_return(:status => 200, :body => "error", :headers => {})

    @user.execute

    @user.wrong?.should be true
  end
end
