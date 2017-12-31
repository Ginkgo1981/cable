class AddSellStateToBookProductions < ActiveRecord::Migration[5.0]
  def change
    add_column :book_productions, :sell_state, :integer, default: 0
  end
end
