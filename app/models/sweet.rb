class Sweet < ApplicationRecord
  # Association
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :relationships_with_users, foreign_key: :sweet_id, class_name: 'Favorite'
  has_many :favorite_sweet_users, through: :relationships_with_users, source: :user

  # Validation
  validates :description, presence: true
end
