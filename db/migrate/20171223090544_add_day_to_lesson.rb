class AddDayToLesson < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :reading_day, :integer, default: 0
    add_column :lessons, :reading_date, :string
  end
end
