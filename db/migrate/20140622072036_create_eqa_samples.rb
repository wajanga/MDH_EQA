class CreateEqaSamples < ActiveRecord::Migration
  def change
    create_table :eqa_samples do |t|
      t.string :specimen_id
      t.string :d_expected_result
      t.string :u_expected_result
      t.string :f_expected_result
      t.integer :eqa_test_id

      t.timestamps
    end

    add_index :eqa_samples, :eqa_test_id
  end
end
