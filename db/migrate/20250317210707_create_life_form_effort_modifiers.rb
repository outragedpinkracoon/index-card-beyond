class CreateLifeFormEffortModifiers < ActiveRecord::Migration[8.0]
  def change
    create_table :life_form_effort_modifiers do |t|
      t.references :life_form, null: false, foreign_key: true
      t.integer :basic_mod
      t.integer :weapons_and_tools_mod
      t.integer :guns_mod
      t.integer :energy_and_magic_mod
      t.integer :ultimate_mod

      t.timestamps
    end
  end
end
