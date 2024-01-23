class CreateIPAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :ip_addresses, id: :uuid do |t|
      t.string :address, null: false
      t.timestamps
      t.index :address, unique: true
    end
  end
end
