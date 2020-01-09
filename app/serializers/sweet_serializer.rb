class SweetSerializer < ActiveModel::Serializer
  attributes :id, :description #:author  #:sweet
  belongs_to :user
  has_many :favorite_sweet_users

  #def sweet
  #  { sweet_id: object.id,
  #    description: object.description,
  #    author: author }
  #end

  #def author
  #  SweetsController.render
  #  { username: object.user.username,
  #  email: object.user.email }
  #  end

end
