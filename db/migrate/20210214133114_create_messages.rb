class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :body, limit: 200, null: false, default: ''
      t.boolean :read, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
