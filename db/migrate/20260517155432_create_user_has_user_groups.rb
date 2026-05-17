class CreateUserHasUserGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :user_has_user_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_group, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_has_user_groups, [ :user_id, :user_group_id ], unique: true
  end
end
