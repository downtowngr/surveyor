class CreateNumberListeners < ActiveRecord::Migration
  def change
    create_table :number_listeners do |t|
      t.string :number, null: false

      t.integer :listening_id, null: false
      t.string  :listening_type, null: false

      t.timestamps
    end

    add_index :number_listeners, :number, unique: true
    add_index :number_listeners, [:listening_id, :listening_type]
  end
end
