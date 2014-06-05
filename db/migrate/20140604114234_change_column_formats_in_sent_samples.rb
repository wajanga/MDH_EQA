class ChangeColumnFormatsInSentSamples < ActiveRecord::Migration
  def change
  	change_column :sent_samples, :d_expected_result, :string
  	change_column :sent_samples, :u_expected_result, :string
  	change_column :sent_samples, :f_expected_result, :string
  end
end
