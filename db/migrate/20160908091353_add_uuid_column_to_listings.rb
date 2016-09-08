class AddUuidColumnToListings < ActiveRecord::Migration
  def up
    execute "ALTER TABLE listings ADD uuid BINARY(16) AFTER `id`"
    execute "ALTER TABLE listings ADD UNIQUE (uuid)"
  end

  def down
    execute "ALTER TABLE listings DROP uuid"
  end
end
