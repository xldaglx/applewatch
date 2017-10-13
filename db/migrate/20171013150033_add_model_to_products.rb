class AddModelToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :model, :string
    add_column :products, :sku, :string
  end
end
