class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.datetime :time
      t.text :description

      t.timestamps
    end
  end
end
