class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.text :user_name
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
