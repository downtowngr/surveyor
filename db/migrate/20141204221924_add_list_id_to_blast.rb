class AddListIdToBlast < ActiveRecord::Migration
  def change
    add_column :blasts, :list_id, :integer
  end
end
