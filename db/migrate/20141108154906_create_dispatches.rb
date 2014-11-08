class CreateDispatches < ActiveRecord::Migration
  def change
    create_table :dispatches do |t|
      t.string :keyword
      t.string :klass

      t.timestamps
    end
  end
end
