class CreateReagentResultTypes < ActiveRecord::Migration
  def change
    create_table :reagent_result_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
