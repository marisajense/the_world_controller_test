class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :population
      t.string :language

      t.timestamps
    end
  end
end
