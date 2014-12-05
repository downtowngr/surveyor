class RemoveBlastsCitizens < ActiveRecord::Migration
  def change
    drop_table :blasts_citizens
  end
end
