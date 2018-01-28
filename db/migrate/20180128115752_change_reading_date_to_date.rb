class ChangeReadingDateToDate < ActiveRecord::Migration[5.0]
  def change
     change_column :user_lessons, :reading_date, 'date USING CAST(reading_date AS date)'
  end
end
