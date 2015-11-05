class CreateShoppingListItems < ActiveRecord::Migration
  def change
    create_table :shopping_list_items do |t|
      t.string :name
      t.belongs_to :shopping_list
      t.timestamp
    end
  end
end
