class AddTestbenchDataToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :testbench_data, :jsonb
  end
end
