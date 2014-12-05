class AddStatusToList < ActiveRecord::Migration
  def change
    add_column :lists, :status, :string
  end
end
