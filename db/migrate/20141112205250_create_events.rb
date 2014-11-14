class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :keyword, index: true
      t.string :autoresponse

      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
