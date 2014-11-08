class AddStrategyToPolls < ActiveRecord::Migration
  def change
    remove_column :polls, :single_vote
    add_column :polls, :polling_strategy, :string
  end
end
