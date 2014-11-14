class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.references :event, index: true
      t.references :citizen, index: true

      t.timestamps
    end
  end
end
