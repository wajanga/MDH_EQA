class AddUniqueIndexToFacilities < ActiveRecord::Migration
  def change
  	remove_index :facilities, :facility_no
  	add_index :facilities, :facility_no, unique: true
  end
end
