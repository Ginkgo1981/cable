class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string   'cell',                limit:50
      t.string   'passwd'
      t.string   'salt'
      t.integer  'sex'
      t.string   'email',               limit: 50
      t.string   'token',               limit: 50
      t.uuid   'identity_id'
      t.string   'identity_type'
      t.timestamps
    end
  end
end
