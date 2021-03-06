require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    before(:each) do
      FactoryGirl.create(:user)
    end

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }

    it { should validate_length_of(:password).is_at_least(6) }
    it { should allow_value(nil).for(:password) }
  end

  describe "associations" do

  end
end
