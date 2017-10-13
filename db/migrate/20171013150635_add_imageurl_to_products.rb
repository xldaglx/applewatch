class AddImageurlToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :imagenurl, :string
  end
end
