class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :article_id
      t.string  :owner_name
      t.text    :body
      t.integer :commentable_id, index: true
      t.string  :commentable_type, index: true
      t.timestamps null: false
    end
  end
end
