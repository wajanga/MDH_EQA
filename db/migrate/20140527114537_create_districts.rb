class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :region_id

      t.timestamps
    end
    add_index :districts, :region_id
  end
end
