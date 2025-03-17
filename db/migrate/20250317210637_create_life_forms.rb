class CreateLifeForms < ActiveRecord::Migration[8.0]
  def change
    create_table :life_forms do |t|
      t.string :name

      t.timestamps
    end
  end
end
