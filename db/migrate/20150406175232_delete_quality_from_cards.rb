class DeleteQualityFromCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :quality
  end
end
