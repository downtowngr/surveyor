class CreateListeningStates < ActiveRecord::Migration
  def change
    create_table :listening_states do |t|
      t.string :number
      t.string :klass
      t.string :event

      t.timestamps
    end
  end
end
