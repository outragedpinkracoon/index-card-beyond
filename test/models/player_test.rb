require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player_type = player_types(:warrior)
    @life_form = life_forms(:human)
    @player = Player.new(
      name: "Test Player",
      world: "Test World",
      story: "A test player's story",
      player_type: @player_type,
      life_form: @life_form,
      base_str: 2,
      base_dex: 1,
      base_con: 1,
      base_int: 1,
      base_wis: 0,
      base_cha: 1,
      max_health: 10
    )
  end

  test "valid player" do
    assert @player.valid?
  end

  test "requires name" do
    @player.name = nil
    refute @player.valid?
    assert_includes @player.errors[:name], "can't be blank"
  end

  test "requires world" do
    @player.world = nil
    refute @player.valid?
    assert_includes @player.errors[:world], "can't be blank"
  end

  test "requires story" do
    @player.story = nil
    refute @player.valid?
    assert_includes @player.errors[:story], "can't be blank"
  end

  test "requires base attributes" do
    @player.base_str = nil
    refute @player.valid?
    assert_includes @player.errors[:base_str], "can't be blank"
  end

  test "base attributes must sum to 6" do
    @player.base_str = 3
    refute @player.valid?
    assert_includes @player.errors[:base], "Base attributes must sum to 6 (got 7)"
  end

  test "requires max_health" do
    @player.max_health = nil
    refute @player.valid?
    assert_includes @player.errors[:max_health], "can't be blank"
  end

  test "max_health must be greater than 0" do
    @player.max_health = 0
    refute @player.valid?
    assert_includes @player.errors[:max_health], "must be greater than 0"
  end

  test "defense calculation" do
    @player.save
    assert_equal 11, @player.defense # base_con (1) + 10
  end

  test "defense with equipment" do
    @player.save
    shield = equipment(:wooden_shield)
    @player.equip(shield)
    assert_equal 14, @player.defense # base_con (1) + 10 + shield defense (3)
  end

  test "health management" do
    @player.save
    assert_equal 10, @player.current_health
    assert_equal 1, @player.hearts

    @player.take_damage(3)
    assert_equal 7, @player.current_health

    @player.heal(2)
    assert_equal 9, @player.current_health
  end

  test "hero coin management" do
    @player.save
    refute @player.hero_coin?

    @player.give_hero_coin
    assert @player.hero_coin?

    @player.remove_hero_coin
    refute @player.hero_coin?
  end

  test "equipment management" do
    @player.save
    sword = equipment(:iron_sword)
    shield = equipment(:wooden_shield)

    @player.equip(sword)
    assert_equal [ sword ], @player.equipment_manager.equipment

    @player.equip(shield)
    assert_equal [ sword, shield ], @player.equipment_manager.equipment

    @player.unequip(sword)
    assert_equal [ shield ], @player.equipment_manager.equipment
  end

  test "attribute calculations with modifiers" do
    @player.save
    sword = equipment(:iron_sword)
    @player.equip(sword)

    attrs = @player.attributes_with_mods
    assert_equal 3, attrs[:str_mod] # base (2) + life_form (0) + sword (1)
    assert_equal 1, attrs[:dex_mod] # base (1) + life_form (0) + sword (0)
  end

  test "effort calculations" do
    @player.save
    sword = equipment(:iron_sword)
    @player.equip(sword)

    efforts = @player.efforts
    assert_equal 1, efforts[:basic_mod] # base (1) + life_form (0) + sword (0)
    assert_equal 3, efforts[:weapons_and_tools_mod] # base (1) + life_form (0) + sword (2)
  end
end
