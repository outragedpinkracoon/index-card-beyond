class CreatePlayerTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :player_types do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
