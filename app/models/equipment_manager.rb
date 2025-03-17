# frozen_string_literal: true

class EquipmentManager
  attr_reader :equipment

  def initialize
    @equipment = []
  end

  def equip(item)
    @equipment << item
  end

  def unequip(item)
    @equipment.delete(item)
  end

  # Returns the total defense modifier from all equipped items
  # This value is used to calculate a character's defense rating
  # @return [Integer] The sum of all defense modifiers
  # @example
  #   manager = EquipmentManager.new
  #   manager.equip(sword)  # defense_mod: 2
  #   manager.equip(shield) # defense_mod: 3
  #   manager.defense_mod   # => 5
  def defense_mod
    equipment.sum { |item| item.defense_mod || 0 }
  end

  # Returns a hash of attribute modifiers from all equipped items
  # This value is used to calculate a character's attribute modifiers
  # @return [Hash] A hash of attribute modifiers
  # @example
  #   manager = EquipmentManager.new
  #   manager.equip(sword)  # attribute_mods: { str: 2, dex: 1 }
  def attribute_mods
    return default_attribute_mods if equipment.empty?

    equipment.each_with_object(default_attribute_mods) do |item, mods|
      item.attribute_mods.each do |attribute, value|
        mods[attribute] = (mods[attribute] || 0) + value
      end
    end
  end

  # Returns a hash of effort modifiers from all equipped items
  # This value is used to calculate a character's effort modifiers
  # @return [Hash] A hash of effort modifiers
  # @example
  #   manager = EquipmentManager.new
  #   manager.equip(sword)  # effort_mods: { basic: 1, weapons_and_tools: 2 }
  #   manager.equip(shield) # effort_mods: { basic: 1, weapons_and_tools: 2 }
  #   manager.effort_mods   # => { basic: 2, weapons_and_tools: 4 }
  def effort_mods
    return default_effort_mods if equipment.empty?

    equipment.each_with_object(default_effort_mods) do |item, mods|
      item.effort_mods.each do |effort, value|
        mods[effort] = (mods[effort] || 0) + value
      end
    end
  end

  private

  def default_attribute_mods
    {
      str_mod: 0,
      dex_mod: 0,
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    }
  end

  def default_effort_mods
    {
      basic_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    }
  end
end
