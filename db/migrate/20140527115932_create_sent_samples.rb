class CreateSentSamples < ActiveRecord::Migration
  def change
    create_table :sent_samples do |t|
      t.string :specimen_id
      t.integer :d_expected_result
      t.integer :u_expected_result
      t.integer :f_expected_result
      t.integer :eqa_test_id

      t.timestamps
    end
    add_index :sent_samples, :d_expected_result
    add_index :sent_samples, :u_expected_result
    add_index :sent_samples, :f_expected_result
    add_index :sent_samples, :eqa_test_id
  end
end
