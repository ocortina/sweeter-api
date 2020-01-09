class CreateRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :relations do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :follower_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :relations, :follower_id
  end
end
