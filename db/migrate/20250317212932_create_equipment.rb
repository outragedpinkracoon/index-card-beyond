class CreateEquipment < ActiveRecord::Migration[8.0]
  def change
    create_table :equipment do |t|
      t.string :name
      t.text :description
      t.integer :str_mod
      t.integer :dex_mod
      t.integer :con_mod
      t.integer :int_mod
      t.integer :wis_mod
      t.integer :cha_mod
      t.integer :basic_mod
      t.integer :weapons_and_tools_mod
      t.integer :guns_mod
      t.integer :energy_and_magic_mod
      t.integer :ultimate_mod
      t.integer :defense_mod

      t.timestamps
    end
  end
end
