class AddNationBuilderTagsToModels < ActiveRecord::Migration
  def change
    add_column :events, :nationbuilder_tag, :string
    add_column :polls, :nationbuilder_tag, :string
  end
end
