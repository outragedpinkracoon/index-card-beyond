class Equipment < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :defense_mod, presence: true

  # Attribute modifiers
  validates :str_mod, :dex_mod, :con_mod, :int_mod, :wis_mod, :cha_mod,
            presence: true,
            numericality: { only_integer: true }

  # Effort modifiers
  validates :basic_mod, :weapons_and_tools_mod, :guns_mod, :energy_and_magic_mod, :ultimate_mod,
            presence: true,
            numericality: { only_integer: true }

  def ==(other)
    name == other.name
  end

  def attribute_mods
    {
      str_mod: str_mod,
      dex_mod: dex_mod,
      con_mod: con_mod,
      int_mod: int_mod,
      wis_mod: wis_mod,
      cha_mod: cha_mod
    }
  end

  def effort_mods
    {
      basic_mod: basic_mod,
      weapons_and_tools_mod: weapons_and_tools_mod,
      guns_mod: guns_mod,
      energy_and_magic_mod: energy_and_magic_mod,
      ultimate_mod: ultimate_mod
    }
  end
end
