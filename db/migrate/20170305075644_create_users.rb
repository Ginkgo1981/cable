class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   'cell',                limit:50
      t.string   'passwd'
      t.string   'salt'
      t.string   'name',           default: ''
      t.integer  'sex'
      t.string   'email',               limit: 50
      t.string   'token',               limit: 50
      t.string   'identity_id',               limit: 50
      t.timestamps
    end
  end
end
