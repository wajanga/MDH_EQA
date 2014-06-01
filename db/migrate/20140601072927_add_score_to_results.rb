class AddScoreToResults < ActiveRecord::Migration
  def change
    add_column :results, :score, :integer
    add_index  :results, :score
  end
end
