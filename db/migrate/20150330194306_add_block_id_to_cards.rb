class AddBlockIdToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :block_id, :integer, null: false
  end
end
