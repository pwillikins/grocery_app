class AddPurchasedToShoppingListItems < ActiveRecord::Migration
  def change
    add_column :shopping_list_items, :purchased, :boolean
    add_column :shopping_list_items, :product_id, :integer
  end
end
