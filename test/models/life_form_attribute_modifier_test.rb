require "test_helper"

class LifeFormAttributeModifierTest < ActiveSupport::TestCase
  def setup
    @life_form = LifeForm.create!(name: "human")
    @modifier = @life_form.life_form_attribute_modifier
  end

  test "should be valid" do
    assert @modifier.valid?
  end

  test "should belong to life form" do
    assert_respond_to @modifier, :life_form
    assert_equal @life_form, @modifier.life_form
  end

  test "should require all attribute modifiers" do
    @modifier.str_mod = nil
    assert_not @modifier.valid?

    @modifier.dex_mod = nil
    assert_not @modifier.valid?

    @modifier.con_mod = nil
    assert_not @modifier.valid?

    @modifier.int_mod = nil
    assert_not @modifier.valid?

    @modifier.wis_mod = nil
    assert_not @modifier.valid?

    @modifier.cha_mod = nil
    assert_not @modifier.valid?
  end

  test "should initialize with zero values" do
    modifier = LifeFormAttributeModifier.new(
      life_form: @life_form,
      str_mod: 0,
      dex_mod: 0,
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    )
    assert modifier.valid?
    assert_equal 0, modifier.str_mod
    assert_equal 0, modifier.dex_mod
    assert_equal 0, modifier.con_mod
    assert_equal 0, modifier.int_mod
    assert_equal 0, modifier.wis_mod
    assert_equal 0, modifier.cha_mod
  end
end
