class AddAttributesToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :autoresponse, :string
    add_column :questions, :citizen_attribute, :string
    add_column :questions, :nationbuilder_tags, :text, array: true, default: []

    remove_column :questions, :nationbuilder_field
  end
end
