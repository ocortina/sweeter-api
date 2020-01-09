require 'rails_helper'

RSpec.describe 'Sweet API', type: :request do
  let!(:user) { create(:user) }
  let(:username) { user.username }
  let!(:sweets) { create_list(:sweet, 10, user_id: user.id) }
  let(:sweet_id) { sweets.first.id }
  let(:headers) { valid_headers }

  # Test suit for GET /:username/sweets
  describe 'GET /:username/sweets' do
    before { get "/#{username}/sweets", params: {}, headers: headers }

    context 'when list of sweets exists' do
      it 'return list of all user sweets' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suit for GET /:username/sweets/:sweet_id
  describe 'GET /:username/sweets/:sweet_id' do
    before { get "/#{username}/sweets/#{sweet_id}", params: {}, headers: headers }

    context 'when sweet exist' do
      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the sweet' do
        expect(json['id']).to eq(sweet_id)
      end
    end

    context 'when sweet does not exist' do
      let(:sweet_id) { 0 }
      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'return a not found sweet message' do
        expect(json['message']).to match(/Could not find sweet/)
      end
    end
  end

  # Test suit for POST /:username/sweets
  describe 'POST /:username/sweets' do
    # valid payload
    let(:valid_attributes) { { description: 'Hola Mundo', user_id: user.id.to_s }.to_json }

    context 'when valid request' do
      before { post "/#{username}/sweets", params: valid_attributes, headers: headers }

      it 'create a new sweet' do
        expect(json['description']).to eq('Hola Mundo')
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when invalid request' do
      let(:invalid_attributes) { { description: nil, user_id: user.id.to_s }.to_json }
      before { post "/#{username}/sweets", params: invalid_attributes, headers: headers }

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return validation message' do
        expect(json['message']).to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suit for PUT /:username/sweets/:sweet_id
  describe 'PUT /:username/sweets/:sweet_id' do
    let(:valid_attributes) { { description: 'Update Hola Mundo', user_id: user.id.to_s }.to_json }

    context 'when valid request' do
      before { put "/#{username}/sweets/#{sweet_id}", params: valid_attributes, headers: headers }

      it 'update sweet description ' do
        expect(json['description']).to eq('Update Hola Mundo')
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when invalid request' do
      let(:invalid_attributes) { { description: nil, user_id: user.id.to_s }.to_json }
      before { put "/#{username}/sweets/#{sweet_id}", params: invalid_attributes, headers: headers }

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return validation message' do
        expect(json['message']).to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suit for DELETE /:username/sweets/favorites/:sweet_id
  describe 'DELETE /:username/sweets/:sweet_id' do
    before { delete "/#{username}/sweets/#{sweet_id}", params: {}, headers: headers }

    context 'when valid request' do
      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return delete successful message' do
        expect(json['message']).to match(/Sweet removed/)
      end
    end
  end
end