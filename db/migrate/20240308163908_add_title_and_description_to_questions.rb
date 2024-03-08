class AddTitleAndDescriptionToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :title, :string
    add_column :questions, :content, :text
  end
end
