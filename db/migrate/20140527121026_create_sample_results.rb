class CreateSampleResults < ActiveRecord::Migration
  def change
    create_table :sample_results do |t|
      t.string :specimen_id
      t.integer :d_result
      t.integer :u_result
      t.integer :f_result
      t.integer :result_id

      t.timestamps
    end
    add_index :sample_results, :d_result
    add_index :sample_results, :u_result
    add_index :sample_results, :f_result
    add_index :sample_results, :result_id
  end
end
