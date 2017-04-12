class AddSatProvinceToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :sat_province, :string
  end
end
