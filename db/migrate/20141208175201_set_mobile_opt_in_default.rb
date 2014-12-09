class SetMobileOptInDefault < ActiveRecord::Migration
  def change
    change_column :citizens, :mobile_opt_in, :boolean, default: true, null: false
  end
end
