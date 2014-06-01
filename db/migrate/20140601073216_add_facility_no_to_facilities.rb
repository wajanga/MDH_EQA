class AddFacilityNoToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :facility_no, :integer
    add_index  :facilities, :facility_no
  end
end
