class AddExtentions < ActiveRecord::Migration[5.0]
  def change
    enable_extension "hstore"
    enable_extension "pgcrypto"
    enable_extension "uuid-ossp"

  end
end
