class AddNationbuilderFieldsToCitizen < ActiveRecord::Migration
  def change
    add_column :citizens, :nationbuilder_id, :integer

    add_column :citizens, :full_name, :string
    add_column :citizens, :email, :string
    add_column :citizens, :mobile_opt_in, :boolean
  end
end
