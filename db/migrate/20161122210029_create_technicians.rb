class CreateTechnicians < ActiveRecord::Migration[5.0]
  def change
    create_table :technicians do |t|
      t.string :name
      t.belongs_to :robot, foreign_key: true

      t.timestamps
    end
  end
end
