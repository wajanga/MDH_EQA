class AddUniqueIndexToEqaSamples < ActiveRecord::Migration
  def change
  	add_index :eqa_samples, [:specimen_id, :eqa_test_id], unique: true
  end
end
