class CreateJoinTableArticleCategory < ActiveRecord::Migration
  def change
    create_join_table :articles, :categories do |t|
      # t.index [:_id, :_id]
      # t.index [:_id, :_id]
    end
  end
end
