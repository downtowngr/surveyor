class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :collected_from

      t.timestamps
    end
  end
end
