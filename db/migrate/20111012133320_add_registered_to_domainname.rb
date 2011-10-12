class AddRegisteredToDomainname < ActiveRecord::Migration
  def self.up
    add_column :domain_names, :registered, :boolean
  end

  def self.down
    remove_column :domain_names, :registered
  end
end
