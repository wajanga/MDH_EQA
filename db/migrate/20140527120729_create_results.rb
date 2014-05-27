class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :facility_id
      t.integer :eqa_test_id
      t.date :sample_receive_date
      t.string :done_by
      t.string :assay1_no
      t.string :assay2_no
      t.string :approved_by
      t.date :test_done_date
      t.date :assay1_expiry_date
      t.date :assay2_expiry_date
      t.date :result_dispatched_date
      t.date :result_received_date

      t.timestamps
    end
    add_index :results, :facility_id
    add_index :results, :eqa_test_id
  end
end
