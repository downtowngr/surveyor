class AddStrategyToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :strategy, :string
  end
end
