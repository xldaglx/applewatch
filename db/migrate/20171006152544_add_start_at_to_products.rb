class AddStartAtToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :start_at, :datetime
  end
end
