class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :poll_choice, index: true
      t.references :citizen, index: true

      t.timestamps
    end
  end
end
