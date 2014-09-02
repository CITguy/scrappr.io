class AddThemeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :theme_id, :integer, null: true, default: 1
  end
end
