class AddUniqueIndexToEqaTests < ActiveRecord::Migration
  def change
  	remove_index :eqa_tests, :eqa_number
  	add_index :eqa_tests, :eqa_number, unique: true
  end
end
