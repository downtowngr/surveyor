class CreateCitizens < ActiveRecord::Migration
  def change
    create_table :citizens do |t|
      t.string :phone_number

      t.timestamps
    end
  end
end
