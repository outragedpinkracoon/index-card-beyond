class LifeFormAttributeModifier < ApplicationRecord
  belongs_to :life_form

  validates :str_mod, :dex_mod, :con_mod, :int_mod, :wis_mod, :cha_mod, presence: true
end
