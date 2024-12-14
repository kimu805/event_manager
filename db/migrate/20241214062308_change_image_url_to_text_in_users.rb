class ChangeImageUrlToTextInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :image_url, :text
  end
end
