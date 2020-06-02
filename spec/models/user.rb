require 'rails_helper'

RSpec.describe User, type: :model do
  let! :each do
    @user = FactoryBot.create(:user)
  end

  describe 'Associations for user' do
    describe 'User' do
      it {should have_many(:tweets)}
    end
  end

  describe 'validations for user' do
    describe 'User' do
      it {is_expected.to validate_presence_of(:full_name)}
      it {is_expected.to validate_uniqueness_of(:authentication_token)}
    end
  end

  describe '.renew_authentication_token' do
    it 'should renew the authentication token' do
      old_token = @user.authentication_token
      expect(@user.renew_authentication_token).to be_truthy
      expect(@user.authentication_token).not_to eq(old_token)
    end
  end
  
end
