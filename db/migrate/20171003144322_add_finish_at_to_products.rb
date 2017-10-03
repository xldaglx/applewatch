class AddFinishAtToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :finish_at, :datetime
  end
end
