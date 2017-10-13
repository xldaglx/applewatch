class RemoveQtycorreaFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :Qtycorrea, :integer
  end
end
