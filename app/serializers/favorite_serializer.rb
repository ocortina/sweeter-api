class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :favorite_sweet
  #belongs_to :user
  #belongs_to :favorite_sweet

  def favorite_sweet
  { id: object.favorite_sweet.id,
    description: object.favorite_sweet.description,
    author: author }
  end

  def author
    { username: object.favorite_sweet.user.username,
      email: object.favorite_sweet.user.email }
  end
end
