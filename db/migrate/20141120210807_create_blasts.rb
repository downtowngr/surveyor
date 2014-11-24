class CreateBlasts < ActiveRecord::Migration
  def change
    create_table :blasts do |t|
      t.string :name
      t.string :message

      t.timestamps
    end
  end
end
