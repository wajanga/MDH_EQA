class CreateFinalResultTypes < ActiveRecord::Migration
  def change
    create_table :final_result_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
