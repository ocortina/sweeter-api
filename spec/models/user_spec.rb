require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # Association test
  it { should have_many(:sweets).dependent(:destroy) }
  it { should have_many(:follower_relationships).dependent(:destroy) }
  it { should have_many(:following_relationships).dependent(:destroy) }
  it { should have_many(:favorite_sweets_relationships).dependent(:destroy) }
  it { should have_many(:favorite_sweets).dependent(:destroy) }


  # Validation tests
  # ensure columns name, username, email and password are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
