class RenameDispatchersToListeners < ActiveRecord::Migration
  def change
    rename_table :dispatches, :listeners
    add_index :listeners, :keyword
  end
end
