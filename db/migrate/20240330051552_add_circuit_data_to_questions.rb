class AddCircuitDataToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :circuit_data, :jsonb
  end
end
