class CreateListedCitizens < ActiveRecord::Migration
  def change
    create_table :listed_citizens do |t|
      t.references :citizen
      t.references :list

      t.timestamps
    end

    add_index :listed_citizens, [:citizen_id, :list_id]
    add_index :listed_citizens, [:list_id, :citizen_id]
  end
end
