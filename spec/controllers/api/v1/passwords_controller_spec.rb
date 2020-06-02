require 'rails_helper'

describe Api::V1::PasswordsController, type: :api do
  let! :each do
    @pwd = 'password111'
    @user = FactoryBot.create(:user, password: @pwd)
  end

  describe 'which should send reset password link #reset_password'do
    # it 'should send email and response to be success' do
    #   response = put "password/reset_password", email: @user.email
    #   response_body = JSON.parse response.body
    #   expect(response.status).to eq(202)
    #   expect(response_body['success']).to eq(true)
    #   expect(response_body['message']).to eq('Password recovery link sent')
    # end

    it 'should respond with invalid email' do
      response = put "api/v1/password/reset_password", email: 'invlid@mail.com'
      response_body = JSON.parse response.body
      expect(response.status).to eq(422)
      expect(response_body['success']).to eq(false)
      expect(response_body['message']).to eq('Email does not exist')
    end

  end

  describe 'which update pwd #update'do
    # it 'should update with valid reset token' do
    #   user = { reset_password_token: @user.send_reset_password_instructions, password: '123456', password_confirmation: '123456' }
    #   response = put "password/update", user: user
    #   response_body = JSON.parse response.body
    #   expect(response.status).to eq(202)
    #   expect(response_body['success']).to eq(true)
    #   expect(response_body['message']).to eq('Password reset successfully')
    # end

    # it 'should not update with invalid passwords and returns appropriate message' do
    #   user = { reset_password_token: @user.send_reset_password_instructions, password: '123457', password_confirmation: '123456' }
    #   response = put "password/update", user: user
    #   response_body = JSON.parse response.body
    #   expect(response.status).to eq(422)
    #   expect(response_body['success']).to eq(false)
    #   expect(response_body['message']).to eq("Password confirmation doesn't match Password")
    # end

    it 'should not update with invalid token and returns appropriate message' do
      user = { reset_password_token: 'reset_link', password: '123456', password_confirmation: '123456' }
      response = put "api/v1/password/update", user: user
      response_body = JSON.parse response.body
      expect(response.status).to eq(422)
      expect(response_body['success']).to eq(false)
      expect(response_body['message']).to eq('Reset password token is invalid')
    end

  end


end
