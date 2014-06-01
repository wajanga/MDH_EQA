class ChangeColumnFormatsInSampleResults < ActiveRecord::Migration
  def change
  	change_column :sample_results, :d_result, :string
  	change_column :sample_results, :u_result, :string
  	change_column :sample_results, :f_result, :string
  end
end
