class AddMaxAllowedToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :max_allowed, :integer
  end
end
