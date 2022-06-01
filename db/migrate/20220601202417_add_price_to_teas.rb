class AddPriceToTeas < ActiveRecord::Migration[5.2]
  def change
    add_column :teas, :price, :integer
  end
end
