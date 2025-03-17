class CreateLifeFormAttributeModifiers < ActiveRecord::Migration[8.0]
  def change
    create_table :life_form_attribute_modifiers do |t|
      t.references :life_form, null: false, foreign_key: true
      t.integer :str_mod
      t.integer :dex_mod
      t.integer :con_mod
      t.integer :int_mod
      t.integer :wis_mod
      t.integer :cha_mod

      t.timestamps
    end
  end
end
