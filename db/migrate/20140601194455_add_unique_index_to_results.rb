class AddUniqueIndexToResults < ActiveRecord::Migration
  def change
  	add_index :results, [:facility_id, :eqa_test_id], unique: true
  end
end
