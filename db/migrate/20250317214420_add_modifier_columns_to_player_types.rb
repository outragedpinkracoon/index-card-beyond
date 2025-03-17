class AddModifierColumnsToPlayerTypes < ActiveRecord::Migration[8.0]
  def change
    add_column :player_types, :description, :text
    add_column :player_types, :str_mod, :integer
    add_column :player_types, :dex_mod, :integer
    add_column :player_types, :con_mod, :integer
    add_column :player_types, :int_mod, :integer
    add_column :player_types, :wis_mod, :integer
    add_column :player_types, :cha_mod, :integer
    add_column :player_types, :basic_mod, :integer
    add_column :player_types, :weapons_and_tools_mod, :integer
    add_column :player_types, :guns_mod, :integer
    add_column :player_types, :energy_and_magic_mod, :integer
    add_column :player_types, :ultimate_mod, :integer
  end
end
