# frozen_string_literal: true

class StatsCalculator
  ATTRIBUTE_NAMES = %i[str_mod dex_mod con_mod int_mod wis_mod cha_mod].freeze
  EFFORT_NAMES = %i[basic_mod weapons_and_tools_mod guns_mod energy_and_magic_mod ultimate_mod].freeze
  BASE_EFFORTS = {
    basic_mod: 1,
    weapons_and_tools_mod: 1,
    guns_mod: 1,
    energy_and_magic_mod: 1,
    ultimate_mod: 1
  }.freeze

  def initialize(base_values:, life_form:, equipment_mods:)
    @base_values = base_values
    @life_form = life_form
    @equipment_mods = equipment_mods
  end

  # Calculates the attributes of a character
  # @return [Hash] A hash of attributes with their calculated values
  # @example
  #   calculator = StatsCalculator.new(base_values: { str_mod: 10 }, life_form: { attribute_mods: { str_mod: 2 } }, equipment_mods: { attribute_mods: { str_mod: 3 } })
  #   calculator.calculate_attributes # => { str_mod: 15 }
  def calculate_attributes
    ATTRIBUTE_NAMES.each_with_object({}) do |attribute_name, obj|
      obj[attribute_name] = calculate_stat(attribute_name, :attribute_mods)
    end
  end

  # Calculates the efforts of a character
  # @return [Hash] A hash of efforts with their calculated values
  # @example
  #   calculator = StatsCalculator.new(base_values: { basic_mod: 10 }, life_form: { effort_mods: { basic_mod: 2 } }, equipment_mods: { effort_mods: { basic_mod: 3 } })
  #   calculator.calculate_efforts # => { basic_mod: 15 }
  def calculate_efforts
    EFFORT_NAMES.each_with_object({}) do |effort_name, obj|
      obj[effort_name] = calculate_stat(effort_name, :effort_mods, BASE_EFFORTS)
    end
  end

  private

  # Calculates the value of a stat by combining base value with life form and equipment modifiers
  # @param stat_name [Symbol] The name of the stat to calculate
  # @param mods_method [Symbol] The method to use to get the modifiers for the stat
  # @param base_values [Hash] The base values for the stat
  # @return [Integer] The calculated value of the stat
  # @example
  #   calculator = StatsCalculator.new(base_values: { str_mod: 10 }, life_form: { attribute_mods: { str_mod: 2 } }, equipment_mods: { attribute_mods: { str_mod: 3 } })
  def calculate_stat(stat_name, mods_method, base_values = @base_values)
    base_value = base_values[stat_name]
    life_form_mod = @life_form.send(mods_method)[stat_name] || 0
    equipment_mod = @equipment_mods[mods_method][stat_name] || 0

    base_value + life_form_mod + equipment_mod
  end
end
