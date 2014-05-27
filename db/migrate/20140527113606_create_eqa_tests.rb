class CreateEqaTests < ActiveRecord::Migration
  def change
    create_table :eqa_tests do |t|
      t.string :eqa_number
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :eqa_tests, :eqa_number
  end
end
