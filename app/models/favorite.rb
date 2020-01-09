class Favorite < ApplicationRecord
  #belongs_to :sweet
  #belongs_to :user

  belongs_to :user
  belongs_to :favorite_sweet, foreign_key: :sweet_id, class_name: 'Sweet'


end
