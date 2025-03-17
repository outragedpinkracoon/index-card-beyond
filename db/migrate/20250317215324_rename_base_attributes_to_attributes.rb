class RenameBaseAttributesToAttributes < ActiveRecord::Migration[7.1]
  def change
    rename_column :players, :base_str, :str
    rename_column :players, :base_dex, :dex
    rename_column :players, :base_con, :con
    rename_column :players, :base_int, :int
    rename_column :players, :base_wis, :wis
    rename_column :players, :base_cha, :cha
  end
end
