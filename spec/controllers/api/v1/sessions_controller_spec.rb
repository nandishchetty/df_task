require 'rails_helper'

describe Api::V1::SessionsController, type: :api do

  let! :each do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
  end

  describe 'when session is created'  do
    it 'should give sucess status and email and auth token response' do
      user = FactoryBot.create(:user, password: '12345678')
      params = { user: { email: user.email, password: '12345678' } }
      response = post 'api/v1/session', params.to_json
      expect(response.status).to eq(201)
    end

    it 'should have response body -  email and authentication_token' do
      user = FactoryBot.create(:user, password: '12345678')
      params = { user: { email: user.email, password: '12345678' } }
      response = post 'api/v1/session', params.to_json
      response_body = JSON.parse response.body
      # expect(response_body["home_gallery_created"]).to eq(false)
      end
    end

    describe 'when email is not valid' do
      it 'should return an error if there is no correct email' do
        params = { user: { email: 'andre', password: 'andre100' } }
        response = post 'api/v1/session', params.to_json
        expect(response.status).to eq(401)
      end
    end

    describe 'when password is blank' do
      it 'should return an error if there is no password' do
        params = { user: { email: 'andre', password: '' } }
        response = post 'api/v1/session', params.to_json
        expect(response.status).to eq(401)
      end
    end

    describe 'when user session delete/ sign out' do
      # TODO:

      it 'should make sucessful sign out' do
        # user = FactoryBot.create(:user, password: '12345678')
        # response = delete 'api/v1/session', {}, { 'X-User-Token' => user.authentication_token, 'X-User-Email' => user.email }
        # expect(response.status).to eq(200)
      end

      it 'should change authentication_token' do
        #   user = FactoryBot.create(:user, password: '12345678')
        #   old_auth_token = user.authentication_token
        #   response = delete 'api/v1/session', {}, { 'X-User-Token' => user.authentication_token, 'X-User-Email' => user.email }
        #   expect(old_auth_token).not_to_be eq(user.reload.authentication_token)
      end
    end

  end
