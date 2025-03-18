require "test_helper"
require "ostruct"

class StatsCalculatorTest < ActiveSupport::TestCase
  def setup
    @base_values = {
      str_mod: 2,
      dex_mod: 1,
      con_mod: 1,
      int_mod: 1,
      wis_mod: 0,
      cha_mod: 1
    }

    @life_form = OpenStruct.new(
      attribute_mods: {
        str_mod: 0,
        dex_mod: 0,
        con_mod: 0,
        int_mod: 0,
        wis_mod: 0,
        cha_mod: 0
      },
      effort_mods: {
        basic_mod: 0,
        weapons_and_tools_mod: 0,
        guns_mod: 0,
        energy_and_magic_mod: 0,
        ultimate_mod: 0
      }
    )

    @equipment_mods = {
      attribute_mods: {
        str_mod: 1,
        dex_mod: 0,
        con_mod: 0,
        int_mod: 0,
        wis_mod: 0,
        cha_mod: 0
      },
      effort_mods: {
        basic_mod: 0,
        weapons_and_tools_mod: 2,
        guns_mod: 0,
        energy_and_magic_mod: 0,
        ultimate_mod: 0
      }
    }

    @calculator = StatsCalculator.new(
      base_values: @base_values,
      life_form: @life_form,
      equipment_mods: @equipment_mods
    )
  end

  test "calculates attributes correctly" do
    attrs = @calculator.calculate_attributes

    assert_equal 3, attrs[:str_mod]  # base (2) + life_form (0) + equipment (1)
    assert_equal 1, attrs[:dex_mod]  # base (1) + life_form (0) + equipment (0)
    assert_equal 1, attrs[:con_mod]  # base (1) + life_form (0) + equipment (0)
    assert_equal 1, attrs[:int_mod]  # base (1) + life_form (0) + equipment (0)
    assert_equal 0, attrs[:wis_mod]  # base (0) + life_form (0) + equipment (0)
    assert_equal 1, attrs[:cha_mod]  # base (1) + life_form (0) + equipment (0)
  end

  test "calculates efforts correctly" do
    efforts = @calculator.calculate_efforts

    assert_equal 1, efforts[:basic_mod]  # base (1) + life_form (0) + equipment (0)
    assert_equal 3, efforts[:weapons_and_tools_mod]  # base (1) + life_form (0) + equipment (2)
    assert_equal 1, efforts[:guns_mod]  # base (1) + life_form (0) + equipment (0)
    assert_equal 1, efforts[:energy_and_magic_mod]  # base (1) + life_form (0) + equipment (0)
    assert_equal 1, efforts[:ultimate_mod]  # base (1) + life_form (0) + equipment (0)
  end

  test "handles life form modifiers" do
    @life_form.attribute_mods[:str_mod] = 2
    @life_form.effort_mods[:basic_mod] = 1

    attrs = @calculator.calculate_attributes
    efforts = @calculator.calculate_efforts

    assert_equal 5, attrs[:str_mod]  # base (2) + life_form (2) + equipment (1)
    assert_equal 2, efforts[:basic_mod]  # base (1) + life_form (1) + equipment (0)
  end

  test "handles negative modifiers" do
    @equipment_mods[:attribute_mods][:str_mod] = -1
    @equipment_mods[:effort_mods][:basic_mod] = -1

    attrs = @calculator.calculate_attributes
    efforts = @calculator.calculate_efforts

    assert_equal 1, attrs[:str_mod]  # base (2) + life_form (0) + equipment (-1)
    assert_equal 0, efforts[:basic_mod]  # base (1) + life_form (0) + equipment (-1)
  end

  test "handles missing modifiers gracefully" do
    @equipment_mods[:attribute_mods].delete(:str_mod)
    @equipment_mods[:effort_mods].delete(:basic_mod)

    attrs = @calculator.calculate_attributes
    efforts = @calculator.calculate_efforts

    assert_equal 2, attrs[:str_mod]  # base (2) + life_form (0) + equipment (0)
    assert_equal 1, efforts[:basic_mod]  # base (1) + life_form (0) + equipment (0)
  end
end
