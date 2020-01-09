require 'rails_helper'

RSpec.describe 'Relation API', type: :request do
  let!(:user) { create(:user, id: 1) }
  let!(:user_2) { create(:user, id: 2) }
  let!(:user_3) { create(:user, id: 3) }
  let!(:user_4) { create(:user, id: 4) }

  let!(:relation_1) { create(:relation, follower_id: user_2.id, following_id: user.id) }
  let!(:relation_2) { create(:relation, follower_id: user_3.id, following_id: user.id) }

  let!(:relation_3) { create(:relation, follower_id: user.id, following_id: user_2.id) }
  let!(:relation_4) { create(:relation, follower_id: user.id, following_id: user_3.id) }

  let(:username) { user.username }
  let(:headers) { valid_headers }

  # Test suit for GET /:username/followers
  describe 'GET /:username/followers' do
    before { get "/#{username}/followers", params: {}, headers: headers}

    context 'when valid request' do
      it 'return list of all user followers ' do
        expect(json.size).to eq(2)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suit for GET /:username/followings
  describe 'GET /:username/followings' do
    before { get "/#{username}/followings", params: {}, headers: headers}

    context 'when valid request' do
      it 'return list of all user followers ' do
        expect(json.size).to eq(2)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suit for POST /:username/following/:following_id
  describe 'POST /:username/following/:following_id' do
    before { post "/#{username}/following/#{user_4.id}", params: {}, headers: headers }

    context 'when valid request' do
      it 'register a new following' do
        expect(json['following']['id']).to match(user_4.id)
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)

      end
    end

    context 'when same request asked again' do
      before { post "/#{username}/following/#{user_2.id}", params: {}, headers: headers }

      it 'return message ' do
        expect(json['message']).to match(/User already following/)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suit for DELETE /:username/following/:following_id
  describe 'DELETE /:username/following/:following_id' do
    context 'when valid request' do
      before { delete "/#{username}/following/#{user_2.id}", params: {}, headers: headers }

      it 'delete following user' do
        expect(json).to eq(nil)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when same request asked again' do
      before { delete "/#{username}/following/#{user_4.id}", params: {}, headers: headers }

      it 'return message ' do
        expect(json['message']).to match(/User not following/)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

end
