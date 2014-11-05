class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :name
      t.boolean :single_vote

      t.timestamp :voting_starts
      t.timestamp :voting_ends

      t.timestamps
    end
  end
end
