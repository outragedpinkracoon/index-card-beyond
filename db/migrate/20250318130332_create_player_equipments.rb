class CreatePlayerEquipments < ActiveRecord::Migration[8.0]
  def change
    create_table :player_equipments do |t|
      t.references :player, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
