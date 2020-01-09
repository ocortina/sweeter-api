require 'rails_helper'

RSpec.describe 'Favorite API', type: :request do
  let!(:user) { create(:user, id: 1) }
  let(:username) { user.username }

  let!(:user_2) { create(:user, id: 2) }

  #let!(:tweets_ids) { [{ id: 1 }, { id: 2 }] }
  let!(:sweets) { create_list(:sweet, 4, user_id: user_2.id) }

  let!(:favorite_1) { create(:favorite, sweet_id: 1, user_id: user.id) }
  let!(:favorite_2) { create(:favorite, sweet_id: 2, user_id: user.id) }
  let!(:favorite_3) { create(:favorite, sweet_id: 3, user_id: user.id) }
  let!(:favorite_4) { create(:favorite, sweet_id: 4, user_id: user.id) }

  #let!(:favorites) { create_list(:favorite, 2, user_id: user.id)}
  #let!(:favorites) { tweets_ids.map { |p| create(:favorite, sweet_id: p, user_id: 2) } }
  let(:sweet_id) { sweets.first.id }

  let!(:sweet_5) { create(:sweet, user_id: 2) }

  let(:headers) { valid_headers }

  # Test suit for GET /:username/favorites
  describe 'GET /:username/favorites' do
    before { get "/#{username}/favorites", params: {}, headers: headers}

    context 'when valid request' do
      it 'return list of favorite sweets' do
        expect(json.size).to eq(4)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suit for POST /:username/sweets/:sweet_id/favorite
  describe 'POST /:username/sweets/:sweet_id/favorite' do
    #let(:sweet_description) { sweets.first.description }
    context 'when valid request' do
      before { post "/#{username}/sweets/#{sweet_5.id}/favorite", params: {}, headers: headers }

      it 'register new favorite sweet' do
        expect(json['favorite_sweet']['id']).to match(sweet_5.id)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when same request asked again' do
      before { post "/#{username}/sweets/#{sweet_id}/favorite", params: {}, headers: headers }

      it 'return message ' do
        expect(json['message']).to match(/Sweet already liked/)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suit for DELETE /:username/sweets/favorites/:sweet_id
  describe 'DELETE /:username/sweets/favorites/:sweet_id' do
    context 'when valid request' do
      before { delete "/#{username}/sweets/favorites/#{sweet_id}", params: {}, headers: headers }

      it 'delete favorite sweet' do
        expect(json).to eq(nil)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when same request asked again' do
      before { delete "/#{username}/sweets/favorites/#{sweet_5.id}", params: {}, headers: headers }

      it 'return message ' do
        expect(json['message']).to match(/Sweet already unliked/)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
