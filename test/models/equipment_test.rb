require "test_helper"

class EquipmentTest < ActiveSupport::TestCase
  def setup
    @equipment = Equipment.new(
      name: "Test Equipment",
      description: "Test Description",
      str_mod: 0,
      dex_mod: 0,
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0,
      basic_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0,
      defense_mod: 0
    )
  end

  test "should be valid" do
    assert @equipment.valid?
  end

  test "name should be present" do
    @equipment.name = nil
    assert_not @equipment.valid?
  end

  test "description should be present" do
    @equipment.description = nil
    assert_not @equipment.valid?
  end

  test "defense_mod should be present" do
    @equipment.defense_mod = nil
    assert_not @equipment.valid?
  end

  test "all attribute modifiers should be present" do
    @equipment.str_mod = nil
    assert_not @equipment.valid?

    @equipment.dex_mod = nil
    assert_not @equipment.valid?

    @equipment.con_mod = nil
    assert_not @equipment.valid?

    @equipment.int_mod = nil
    assert_not @equipment.valid?

    @equipment.wis_mod = nil
    assert_not @equipment.valid?

    @equipment.cha_mod = nil
    assert_not @equipment.valid?
  end

  test "all effort modifiers should be present" do
    @equipment.basic_mod = nil
    assert_not @equipment.valid?

    @equipment.weapons_and_tools_mod = nil
    assert_not @equipment.valid?

    @equipment.guns_mod = nil
    assert_not @equipment.valid?

    @equipment.energy_and_magic_mod = nil
    assert_not @equipment.valid?

    @equipment.ultimate_mod = nil
    assert_not @equipment.valid?
  end

  test "can have multiple attribute modifiers" do
    @equipment.str_mod = 1
    @equipment.dex_mod = 1
    assert @equipment.valid?

    assert_equal 1, @equipment.str_mod
    assert_equal 1, @equipment.dex_mod
  end

  test "can have multiple effort modifiers" do
    @equipment.basic_mod = 1
    @equipment.weapons_and_tools_mod = 1
    assert @equipment.valid?

    assert_equal 1, @equipment.basic_mod
    assert_equal 1, @equipment.weapons_and_tools_mod
  end

  test "can have negative modifiers" do
    @equipment.str_mod = -1
    @equipment.dex_mod = -1
    assert @equipment.valid?

    assert_equal(-1, @equipment.str_mod)
    assert_equal(-1, @equipment.dex_mod)
  end

  test "can be equipped by multiple players" do
    @equipment.save
    player1 = players(:one)
    player2 = players(:two)

    player1.equip(@equipment)
    player2.equip(@equipment)

    assert_equal 2, @equipment.players.count
    assert_includes @equipment.players, player1
    assert_includes @equipment.players, player2
  end

  test "can be unequipped" do
    @equipment.save
    player = players(:one)
    player.equip(@equipment)

    assert_equal 1, @equipment.players.count
    assert_includes @equipment.players, player

    player.unequip(@equipment)
    assert_empty @equipment.players
  end

  test "attribute modifiers are correctly summed" do
    @equipment.save
    player = players(:one)
    sword = equipment(:iron_sword)
    shield = equipment(:wooden_shield)

    player.equip(sword)
    player.equip(shield)

    attrs = player.attributes_with_mods
    assert_equal 4, attrs[:str_mod] # base (3) + sword (1) + shield (0)
    assert_equal 4, attrs[:con_mod] # base (3) + sword (0) + shield (1)
  end

  test "effort modifiers are correctly summed" do
    @equipment.save
    player = players(:one)
    sword = equipment(:iron_sword)
    shield = equipment(:wooden_shield)

    player.equip(sword)
    player.equip(shield)

    efforts = player.efforts
    assert_equal 5, efforts[:weapons_and_tools_mod] # base (3) + sword (2) + shield (0)
  end

  test "defense modifiers are correctly summed" do
    @equipment.save
    player = players(:one)
    sword = equipment(:iron_sword)
    shield = equipment(:wooden_shield)

    player.equip(sword)
    player.equip(shield)

    assert_equal 17, player.defense # base (13) + sword (1) + shield (3)
  end
end
