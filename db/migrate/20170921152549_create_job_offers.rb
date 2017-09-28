class CreateJobOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :job_offers,  id: :uuid  do |t|
      t.uuid :user_job_id
      t.string :note
      t.timestamps
    end
  end
end