class CreateGroupPermissions < ActiveRecord::Migration[8.1]
  def change
    create_table :group_permissions do |t|
      t.references :user_group, null: false, foreign_key: true
      t.string :permission, null: false

      t.timestamps
    end

    add_index :group_permissions, [ :user_group_id, :permission ], unique: true
  end
end
