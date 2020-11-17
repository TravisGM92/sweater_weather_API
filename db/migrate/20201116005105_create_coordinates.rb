class CreateCoordinates < ActiveRecord::Migration[5.2]
  def change
    create_table :coordinates do |t|
      t.string :city
      t.string :area
      t.string :lat
      t.string :lng
    end
  end
end
