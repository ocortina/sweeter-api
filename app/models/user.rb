class User < ApplicationRecord
  # Password Encryption
  has_secure_password

  # Association
  has_many :sweets, dependent: :destroy
  has_many :relations, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_sweets_relationships, foreign_key: :user_id, class_name: 'Favorite', dependent: :destroy
  has_many :favorite_sweets, through: :favorite_sweets_relationships, source: :favorite_sweet, dependent: :destroy

  #has_many :favorite_sweets, through: :favorites, foreign_key: "sweet_id", source: :sweet, dependent: :destroy
  #has_many :f_sweets, through: :favorites
  has_many :relations, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Relation', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower, dependent: :destroy

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Relation', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following, dependent: :destroy



  # Validations
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  #validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/ }
  validates :password_digest, presence: true

  #validates_presence_of :name, :username, :email, :password_digest
  #
  #
  #


  #def like_sweet(sw_id)
  #  favorite_sweets_relationships.create(sweet_id: sw_id)
  #end

  #def unlike_sweet(sw_id)
  #  favorite_sweets_relationships.find_by(sweet_id: sw_id).destroy
  #end

end