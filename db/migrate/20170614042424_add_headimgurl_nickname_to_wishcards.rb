class AddHeadimgurlNicknameToWishcards < ActiveRecord::Migration[5.0]
  def change
    add_column :wishcards, :nickname, :string
    add_column :wishcards, :headimgurl, :string
  end
end
