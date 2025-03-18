class CreateUserRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :user_roles, id: false do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.timestamps
    end
  end
end
