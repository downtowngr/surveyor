class CreatePollChoices < ActiveRecord::Migration
  def change
    create_table :poll_choices do |t|
      t.references :poll, index: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
