class AddFacilityIdToSentSamples < ActiveRecord::Migration
  def change
  	add_column :sent_samples, :facility_id, :integer
    add_index  :sent_samples, :facility_id
  end
end
