class CreateInternetProtocols < ActiveRecord::Migration[7.0]
  def change
    create_table :internet_protocols, id: :uuid do |t|
      t.string :address, null: false
      t.datetime :created_at, null: false
      t.index :address, unique: true
    end
  end
end
