class RenameCategoriesIdColumnToIdeas < ActiveRecord::Migration[6.1]
  def change
    rename_column :ideas, :categories_id, :category_id
  end
end
