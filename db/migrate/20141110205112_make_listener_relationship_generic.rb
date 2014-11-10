class MakeListenerRelationshipGeneric < ActiveRecord::Migration
  def change
    remove_column :listeners, :poll_id
    add_column :listeners, :listening_id, :integer
    add_column :listeners, :listening_type, :string

    add_index :listeners, [:listening_id, :listening_type]
  end
end
