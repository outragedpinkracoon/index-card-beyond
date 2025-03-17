require "test_helper"

class EquipmentManagerTest < ActiveSupport::TestCase
  def setup
    @manager = EquipmentManager.new
    @sword = Equipment.create!(
      name: "Sword",
      description: "A sharp sword",
      str_mod: 1,
      weapons_and_tools_mod: 1,
      defense_mod: 2,
      dex_mod: 0,
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0,
      basic_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    )
    @shield = Equipment.create!(
      name: "Shield",
      description: "A sturdy shield",
      con_mod: 1,
      basic_mod: 1,
      defense_mod: 3,
      str_mod: 0,
      dex_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    )
    @ring = Equipment.create!(
      name: "Ring of Power",
      description: "A magical ring",
      str_mod: 1,
      dex_mod: 1,
      energy_and_magic_mod: 1,
      defense_mod: 1,
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0,
      basic_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      ultimate_mod: 0
    )
  end

  test "equip item" do
    @manager.equip(@sword)
    assert_equal [ @sword ], @manager.equipment
  end

  test "unequip item" do
    @manager.equip(@sword)
    @manager.unequip(@sword)
    assert_empty @manager.equipment
  end

  test "defense mod" do
    @manager.equip(@sword)
    @manager.equip(@shield)
    assert_equal 5, @manager.defense_mod
  end

  test "attribute mods" do
    @manager.equip(@sword)
    @manager.equip(@shield)

    expected = {
      str_mod: 1,
      dex_mod: 0,
      con_mod: 1,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    }

    assert_equal expected, @manager.attribute_mods
  end

  test "effort mods" do
    @manager.equip(@sword)
    @manager.equip(@shield)

    expected = {
      basic_mod: 1,
      weapons_and_tools_mod: 1,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    }

    assert_equal expected, @manager.effort_mods
  end

  test "item with multiple attribute mods" do
    @manager.equip(@ring)

    expected = {
      str_mod: 1,
      dex_mod: 1,
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    }

    assert_equal expected, @manager.attribute_mods
  end

  test "multiple items with overlapping attribute mods" do
    @manager.equip(@sword)
    @manager.equip(@ring)

    expected = {
      str_mod: 2,  # 1 from sword + 1 from ring
      dex_mod: 1,  # 1 from ring
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    }

    assert_equal expected, @manager.attribute_mods
  end

  test "handles negative modifiers" do
    cursed_ring = Equipment.create!(
      name: "Cursed Ring",
      description: "A cursed ring",
      str_mod: -1,
      dex_mod: -1,
      defense_mod: 0,
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0,
      basic_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    )

    @manager.equip(cursed_ring)
    @manager.equip(@sword)

    expected = {
      str_mod: 0,  # 1 from sword - 1 from cursed ring
      dex_mod: -1, # -1 from cursed ring
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    }

    assert_equal expected, @manager.attribute_mods
  end

  test "handles empty equipment list" do
    assert_equal 0, @manager.defense_mod
    assert_equal(
      {
        str_mod: 0,
        dex_mod: 0,
        con_mod: 0,
        int_mod: 0,
        wis_mod: 0,
        cha_mod: 0
      },
      @manager.attribute_mods
    )
    assert_equal(
      {
        basic_mod: 0,
        weapons_and_tools_mod: 0,
        guns_mod: 0,
        energy_and_magic_mod: 0,
        ultimate_mod: 0
      },
      @manager.effort_mods
    )
  end
end
