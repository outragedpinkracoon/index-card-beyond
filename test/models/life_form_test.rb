require "test_helper"

class LifeFormTest < ActiveSupport::TestCase
  def setup
    @life_form = LifeForm.new(name: "human")
  end

  test "should be valid" do
    assert @life_form.valid?
  end

  test "name should be present" do
    @life_form.name = nil
    assert_not @life_form.valid?
  end

  test "name should be unique" do
    duplicate_life_form = @life_form.dup
    @life_form.save
    assert_not duplicate_life_form.valid?
  end

  test "name should be in predefined list" do
    @life_form.name = "invalid_name"
    assert_not @life_form.valid?
    assert_includes @life_form.errors[:name], "is not included in the list"
  end

  test "should have one attribute modifier" do
    @life_form.save
    assert_respond_to @life_form, :life_form_attribute_modifier
  end

  test "should have one effort modifier" do
    @life_form.save
    assert_respond_to @life_form, :life_form_effort_modifier
  end

  test "should create associated modifiers" do
    assert_difference -> { LifeFormAttributeModifier.count } do
      assert_difference -> { LifeFormEffortModifier.count } do
        @life_form.save
      end
    end
  end

  test "human should have correct modifiers" do
    human = LifeForm.create!(name: "human")
    attrs = human.life_form_attribute_modifier
    efforts = human.life_form_effort_modifier

    assert_equal 0, attrs.str_mod
    assert_equal 0, attrs.dex_mod
    assert_equal 0, attrs.con_mod
    assert_equal 1, attrs.int_mod
    assert_equal 0, attrs.wis_mod
    assert_equal 1, attrs.cha_mod

    assert_equal 0, efforts.basic_mod
    assert_equal 0, efforts.weapons_and_tools_mod
    assert_equal 0, efforts.guns_mod
    assert_equal 0, efforts.energy_and_magic_mod
    assert_equal 0, efforts.ultimate_mod
  end

  test "elf should have correct modifiers" do
    elf = LifeForm.create!(name: "elf")
    attrs = elf.life_form_attribute_modifier
    efforts = elf.life_form_effort_modifier

    assert_equal 0, attrs.str_mod
    assert_equal 1, attrs.dex_mod
    assert_equal(-1, attrs.con_mod)
    assert_equal 0, attrs.int_mod
    assert_equal 0, attrs.wis_mod
    assert_equal 0, attrs.cha_mod

    assert_equal 0, efforts.basic_mod
    assert_equal 0, efforts.weapons_and_tools_mod
    assert_equal 0, efforts.guns_mod
    assert_equal 1, efforts.energy_and_magic_mod
    assert_equal 0, efforts.ultimate_mod
  end

  test "dwarf should have correct modifiers" do
    dwarf = LifeForm.create!(name: "dwarf")
    attrs = dwarf.life_form_attribute_modifier
    efforts = dwarf.life_form_effort_modifier

    assert_equal 0, attrs.str_mod
    assert_equal(-1, attrs.dex_mod)
    assert_equal 1, attrs.con_mod
    assert_equal 0, attrs.int_mod
    assert_equal 0, attrs.wis_mod
    assert_equal 0, attrs.cha_mod

    assert_equal 0, efforts.basic_mod
    assert_equal 1, efforts.weapons_and_tools_mod
    assert_equal 0, efforts.guns_mod
    assert_equal 0, efforts.energy_and_magic_mod
    assert_equal 0, efforts.ultimate_mod
  end

  test "gerblin should have correct modifiers" do
    gerblin = LifeForm.create!(name: "gerblin")
    attrs = gerblin.life_form_attribute_modifier
    efforts = gerblin.life_form_effort_modifier

    assert_equal(-1, attrs.str_mod)
    assert_equal 1, attrs.dex_mod
    assert_equal 0, attrs.con_mod
    assert_equal 0, attrs.int_mod
    assert_equal 0, attrs.wis_mod
    assert_equal 0, attrs.cha_mod

    assert_equal 0, efforts.basic_mod
    assert_equal 0, efforts.weapons_and_tools_mod
    assert_equal 0, efforts.guns_mod
    assert_equal 0, efforts.energy_and_magic_mod
    assert_equal 0, efforts.ultimate_mod
  end

  test "torton should have correct modifiers" do
    torton = LifeForm.create!(name: "torton")
    attrs = torton.life_form_attribute_modifier
    efforts = torton.life_form_effort_modifier

    assert_equal 1, attrs.str_mod
    assert_equal(-1, attrs.dex_mod)
    assert_equal 1, attrs.con_mod
    assert_equal 0, attrs.int_mod
    assert_equal 0, attrs.wis_mod
    assert_equal 0, attrs.cha_mod

    assert_equal 0, efforts.basic_mod
    assert_equal 0, efforts.weapons_and_tools_mod
    assert_equal 0, efforts.guns_mod
    assert_equal 0, efforts.energy_and_magic_mod
    assert_equal 0, efforts.ultimate_mod
  end
end
