class CreateBlastsCitizensTable < ActiveRecord::Migration
  def change
    create_join_table :blasts, :citizens

    add_index :blasts_citizens, [:blast_id, :citizen_id]
    add_index :blasts_citizens, [:citizen_id, :blast_id]
  end
end
