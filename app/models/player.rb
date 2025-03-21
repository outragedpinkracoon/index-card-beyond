# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :player_type
  belongs_to :life_form
  has_many :player_equipment, dependent: :destroy
  has_many :equipment, through: :player_equipment

  validates :name, :world, :story, presence: true
  validates :str, :dex, :con, :int, :wis, :cha,
            presence: true,
            numericality: { only_integer: true }
  validates :max_health,
            presence: true,
            numericality: { greater_than: 0, only_integer: true }
  validate :validate_base_attributes

  after_initialize :setup_managers

  def defense
    base_defense = base_attributes[:con_mod] + life_form.attribute_mods[:con_mod] + 10
    base_defense + equipment.sum(:defense_mod)
  end

  def take_damage(amount)
    @health.take_damage(amount)
  end

  def heal(amount)
    @health.heal(amount)
  end

  def hearts
    @health.hearts
  end

  def current_health
    @health.current_health
  end

  def give_hero_coin
    @hero_coin = true
  end

  def remove_hero_coin
    @hero_coin = false
  end

  def hero_coin?
    @hero_coin
  end

  def equip(item)
    player_equipment.create(equipment: item)
    create_stats_calculator
  end

  def unequip(item)
    player_equipment.find_by(equipment: item)&.destroy
    create_stats_calculator
  end

  def attributes_with_mods
    stats_calculator.calculate_attributes
  end

  def efforts
    stats_calculator.calculate_efforts
  end

  private

  attr_reader :stats_calculator

  def setup_managers
    return unless life_form # Skip if life_form isn't set yet (new record)

    @hero_coin = false
    @health = Health.new(max_health: max_health || 10)
    create_stats_calculator
  end

  def create_stats_calculator
    @stats_calculator = StatsCalculator.new(
      base_values: base_attributes,
      life_form: life_form,
      equipment_mods: equipment_mods
    )
  end

  def base_attributes
    {
      str_mod: str,
      dex_mod: dex,
      con_mod: con,
      int_mod: int,
      wis_mod: wis,
      cha_mod: cha
    }
  end

  def equipment_mods
    {
      attribute_mods: {
        str_mod: equipment.sum(:str_mod),
        dex_mod: equipment.sum(:dex_mod),
        con_mod: equipment.sum(:con_mod),
        int_mod: equipment.sum(:int_mod),
        wis_mod: equipment.sum(:wis_mod),
        cha_mod: equipment.sum(:cha_mod)
      },
      effort_mods: {
        basic_mod: equipment.sum(:basic_mod),
        weapons_and_tools_mod: equipment.sum(:weapons_and_tools_mod),
        guns_mod: equipment.sum(:guns_mod),
        energy_and_magic_mod: equipment.sum(:energy_and_magic_mod),
        ultimate_mod: equipment.sum(:ultimate_mod)
      }
    }
  end

  def validate_base_attributes
    return if str.nil? || dex.nil? || con.nil? || int.nil? || wis.nil? || cha.nil?

    begin
      BaseAttributes.new(
        str: str,
        dex: dex,
        con: con,
        int: int,
        wis: wis,
        cha: cha
      )
    rescue BaseAttributes::StatsError => e
      errors.add(:base, e.message)
    end
  end
end
