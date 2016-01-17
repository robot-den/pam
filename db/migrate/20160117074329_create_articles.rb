class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|

      t.string  :header, null: false
      t.string  :announce, null: false
      t.text    :body, null: false
      t.belongs_to :user, null: false
      t.boolean :approved, default: false
      t.timestamps null: false
    end
  end
end
