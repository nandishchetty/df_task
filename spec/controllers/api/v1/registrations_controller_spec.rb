require 'rails_helper'

describe Api::V1::RegistrationsController, type: :api do

  let! :each do
    header 'Accept', 'application/json'
    header 'Content-Type', 'application/json'
  end

  describe 'user creation' do
    it 'should increment a record and expect sucess response' do
      params = { user: { full_name: 'a b', email: 'andre@a.com', password: 'password' } }
      response = post "api/v1/registrations", params.to_json
      expect(response.status).to eq(201)
      expect(User.count).to eq(1)
    end

    it 'should do the validation for email address to check dot presence' do
      params = { user: { full_name: 'a b', email: 'email@domain.com', password: 'password' } }
      response = post "api/v1/registrations", params.to_json
      expect(response.status).to eq(201)
    end

    it 'should return false if email does not contain dot in domain' do
      params = { user: { full_name: 'a b', email: 'email@domain', password: 'password' } }
      response = post "api/v1/registrations", params.to_json
      response_body = JSON.parse(response.body)
      # expect(response_body['user']['errors'].first).to eq('Email is invalid')
      # expect(response.status).to eq(422)
    end
  end

  describe 'user registartion test' do
    it 'should return an error if there is no correct email' do
      params = { user: { email: 'andre', password: 'andre100' } }
      response = post 'api/v1/registrations', params.to_json
      expect(response.status).to eq(422)
    end

    it 'should return an error if there is no password' do
      params = { user: { email: 'andre', password: '' } }
      response = post 'api/v1/registrations', params.to_json
      expect(response.status).to eq(422)
    end
  end

  describe 'which is getting correct email' do
    it 'should one increment record ' do
      params = { user: { full_name: 'c d', email: 'cd@a.com', password: 'password' } }
      response = post 'api/v1/registrations', params.to_json
      response_body = JSON.parse response.body
      expect(response_body['user']['email']).to eq('cd@a.com')
    end
  end

end
