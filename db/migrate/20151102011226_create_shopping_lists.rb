class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.string :name
      t.belongs_to :user
      t.timestamp
    end
  end
end
