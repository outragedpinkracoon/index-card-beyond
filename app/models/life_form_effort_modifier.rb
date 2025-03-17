class LifeFormEffortModifier < ApplicationRecord
  belongs_to :life_form

  validates :basic_mod, :weapons_and_tools_mod, :guns_mod, :energy_and_magic_mod, :ultimate_mod, presence: true
end
