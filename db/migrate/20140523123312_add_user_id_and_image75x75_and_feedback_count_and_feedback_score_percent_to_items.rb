class AddUserIdAndImage75x75AndFeedbackCountAndFeedbackScorePercentToItems < ActiveRecord::Migration
  def change
    add_column :items, :image_75x75, :string
    add_column :items, :feedback_count, :integer
    add_column :items, :feedback_score_percent, :integer
  end
end
