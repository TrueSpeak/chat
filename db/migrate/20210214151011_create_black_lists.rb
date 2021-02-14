class CreateBlackLists < ActiveRecord::Migration[6.1]
  def change
    create_table :black_lists do |t|
      t.references :user, polymorphic: true, null: false

      t.timestamps
    end
  end
end
