class AddCounterCacheToWishcard < ActiveRecord::Migration[5.0]
  def change
    add_column :wishcards, :count_of_like, :integer, default: 0
  end
end
