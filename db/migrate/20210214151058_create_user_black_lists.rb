class CreateUserBlackLists < ActiveRecord::Migration[6.1]
  def change
    create_table :user_black_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :black_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
