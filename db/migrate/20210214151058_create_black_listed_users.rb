class CreateBlackListedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :black_listed_users do |t|
      t.integer :user_id, null: false
      t.references :black_list, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key 'black_listed_users', 'users', column: :user_id, primary_key: :id
  end
end
