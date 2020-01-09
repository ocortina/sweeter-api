class RelationSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :follower
  belongs_to :following

  #def follower
  #  { user_id: object.follower.id,
  #    username: object.follower.username,
  #    email: object.follower.email }
  #end

  #def following
  #  { user_id: object.following.id,
  #    username: object.following.username,
  #    email: object.following.email }
  #ºend
end
