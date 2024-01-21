class CreateInternetProtocols < ActiveRecord::Migration[7.0]
  def change
    create_table :internet_protocols, id: :uuid do |t|
      t.string :name, null: false
      t.datetime :created_at, null: false
      t.index :name, unique: true
    end
  end
end
