class CreatePollChoices < ActiveRecord::Migration
  def change
    create_table :poll_choices do |t|
      t.integer :poll_id
      t.integer :vote_count
      t.integer :keyword_id

      t.timestamps
    end
  end
end
