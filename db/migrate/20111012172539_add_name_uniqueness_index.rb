class AddNameUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :domain_names, :name, :unique => true
  end

  def self.down
    remove_index :domain_names, :name
  end
end
