class AddQtycorreaToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :qtycorrea, :integer
  end
end
