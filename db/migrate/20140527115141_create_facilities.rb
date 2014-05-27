class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.integer :facility_type_id
      t.integer :district_id

      t.timestamps
    end
    add_index :facilities, :facility_type_id
    add_index :facilities, :district_id
  end
end
