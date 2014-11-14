class AddUniqueConstraintOnKeyword < ActiveRecord::Migration
  def change
    change_column :listeners, :keyword, :string, null: false
    change_column :listeners, :listening_id, :integer, null: false
    change_column :listeners, :listening_type, :string, null: false

    remove_index :listeners, :keyword
    add_index :listeners, :keyword, unique: true
  end
end
