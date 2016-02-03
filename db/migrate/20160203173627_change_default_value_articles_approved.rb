class ChangeDefaultValueArticlesApproved < ActiveRecord::Migration
  def change
    change_column_default(:articles, :approved, nil)
  end
end
