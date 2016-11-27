class CreateRobots < ActiveRecord::Migration[5.0]
  def change
    create_table :robots do |t|
      t.string :name
      t.string :serial
      t.boolean :friendly

      t.timestamps
    end
  end
end
