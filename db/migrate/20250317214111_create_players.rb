class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name
      t.text :description
      t.string :world
      t.text :story
      t.integer :base_str
      t.integer :base_dex
      t.integer :base_con
      t.integer :base_int
      t.integer :base_wis
      t.integer :base_cha
      t.integer :max_health
      t.references :player_type, null: false, foreign_key: true
      t.references :life_form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
