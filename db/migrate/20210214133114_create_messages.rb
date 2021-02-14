class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :body, limit: 200
      t.boolean :read
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
