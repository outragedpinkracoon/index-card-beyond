class LifeForm < ApplicationRecord
  has_one :life_form_attribute_modifier, dependent: :destroy
  has_one :life_form_effort_modifier, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  TYPES = %w[human elf dwarf gerblin torton].freeze
  validates :name, inclusion: { in: TYPES }

  after_create :create_default_modifiers

  private

  def create_default_modifiers
    create_attribute_modifiers
    create_effort_modifiers
  end

  def create_attribute_modifiers
    attrs = case name
    when "human"
      { int_mod: 1, cha_mod: 1 }
    when "elf"
      { dex_mod: 1, con_mod: -1 }
    when "dwarf"
      { dex_mod: -1, con_mod: 1 }
    when "gerblin"
      { str_mod: -1, dex_mod: 1 }
    when "torton"
      { str_mod: 1, dex_mod: -1, con_mod: 1 }
    end

    create_life_form_attribute_modifier!(
      str_mod: attrs[:str_mod] || 0,
      dex_mod: attrs[:dex_mod] || 0,
      con_mod: attrs[:con_mod] || 0,
      int_mod: attrs[:int_mod] || 0,
      wis_mod: attrs[:wis_mod] || 0,
      cha_mod: attrs[:cha_mod] || 0
    )
  end

  def create_effort_modifiers
    efforts = case name
    when "elf"
      { energy_and_magic_mod: 1 }
    when "dwarf"
      { weapons_and_tools_mod: 1 }
    else
      {}
    end

    create_life_form_effort_modifier!(
      basic_mod: efforts[:basic_mod] || 0,
      weapons_and_tools_mod: efforts[:weapons_and_tools_mod] || 0,
      guns_mod: efforts[:guns_mod] || 0,
      energy_and_magic_mod: efforts[:energy_and_magic_mod] || 0,
      ultimate_mod: efforts[:ultimate_mod] || 0
    )
  end
end
