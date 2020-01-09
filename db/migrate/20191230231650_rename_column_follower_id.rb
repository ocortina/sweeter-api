class RenameColumnFollowerId < ActiveRecord::Migration[6.0]
  def change
    rename_column :relations, :follower_id, :following_id
    rename_column :relations, :user_id, :follower_id
  end
end
