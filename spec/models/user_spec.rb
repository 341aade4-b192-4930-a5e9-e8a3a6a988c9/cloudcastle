require 'spec_helper'

describe User do
  def setup_stub_request_followers(status, body)
    stub_request(:get, /followers/).
      to_return(:status => status, :body => body, :headers => {})
  end

  def setup_stub_request_repos(status, body)
    stub_request(:get, /repos/).
      to_return(:status => status, :body => body, :headers => {})
  end

  def setup_stub_request(status, body)
    setup_stub_request_followers(status, body)
    setup_stub_request_repos(status, body)
  end

  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:rating1) }
  it { should respond_to(:rating2) }

  describe "should give correct raiting and status" do
    before {
      json_answer_followers = '[ { "login": "follower1", "id": 1 }, { "login": "follower2", "id": 2 } ]'

      json_answer_repos = '[ { "id": 1, "forks": 8,"watchers": 5 }, { "id": 1, "forks": 8,"watchers": 5 } ]'

      setup_stub_request_followers(200, json_answer_followers)

      setup_stub_request_repos(200, json_answer_repos)

      @user.execute
    }

    its(:rating1) { should == 12 }
    its(:rating2) { should == 16 }

    its(:status) { should == "completed" }
  end

  describe "should give wrong status" do
    before {
      setup_stub_request 500, "error"

      @user.execute
    }

    its(:status) { should == "wrong" }
  end

  describe "should give rate_limit status" do
    before {
      json_answer = '{ "message": "You have triggered an abuse detection mechanism..." }';

      setup_stub_request 403, json_answer

      @user.execute
    }

    its(:status) { should == "rate_limit" }
  end

  describe "should give not_found status" do
    before {
      json_answer = '{ "message": "Not Found" }';

      setup_stub_request 404, json_answer

      @user.execute
    }

    its(:status) { should == "not_found" }
  end

  describe "has invalid symbols" do
    subject { @user = FactoryGirl.build(:user_with_invalid_symbols) }

    it { should_not be_valid }
  end

  describe "has long name" do
    subject { @user = FactoryGirl.build(:user_with_long_name) }

    it { should_not be_valid }
  end

end
