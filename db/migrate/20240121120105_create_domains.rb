class CreateDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :domains, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps
      t.belongs_to :ip_address, null: false, foreign_key: true, type: :uuid
      t.index :name, unique: true
    end
  end
end
