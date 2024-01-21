class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :continent_code
      t.string :continent_name
      t.string :country_code
      t.string :country_name
      t.string :region_code
      t.string :region_name
      t.string :city
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.timestamps
      t.index :continent_code
      t.index :continent_name
      t.index :country_code
      t.index :country_name
      t.index :region_code
      t.index :region_name
      t.index :city
      t.index :zip
      t.index :latitude
      t.index :longitude
      t.belongs_to :internet_protocol, null: false, foreign_key: true, type: :uuid
    end
  end
end
