class RemoveListeningStates < ActiveRecord::Migration
  def change
    drop_table :listening_states
  end
end
