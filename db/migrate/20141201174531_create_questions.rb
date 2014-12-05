class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :prompt
      t.string :nationbuilder_field

      t.references :blast

      t.timestamps
    end
  end
end
