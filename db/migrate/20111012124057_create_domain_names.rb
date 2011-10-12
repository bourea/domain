class CreateDomainNames < ActiveRecord::Migration
  def self.up
    create_table :domain_names do |t|
      t.string :name
      t.string :source
      t.boolean :available
      t.string :registrar
      t.date :created_on
      t.date :updated_on
      t.date :expires_on

      t.timestamps
    end
  end

  def self.down
    drop_table :domain_names
  end
end
