class RemoveNicknameFromReview < ActiveRecord::Migration
  def change
    remove_column :reviews, :nickname, :string
  end
end
