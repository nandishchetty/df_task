require 'rails_helper'

describe Api::V1::TweetsController, type: :api do
  let! :each do
    @user = FactoryBot.create(:regular_user)
    @user1 = FactoryBot.create(:user)
    header 'X-User-Token', @user.authentication_token
    header 'X-User-Email', @user.email
  end
end

  describe 'tweet creation' do
    it 'should increment a record and expect sucess response' do
    
    end
  end

