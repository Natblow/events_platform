class RemoveAddressFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :address, :string
    remove_column :events, :longitude, :string
    remove_column :events, :latitude, :string
  end
end
