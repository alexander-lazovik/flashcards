class ChangeLocaleNullTrueForUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :locale, :string, null: true
  end
end
