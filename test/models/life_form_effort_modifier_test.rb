require "test_helper"

class LifeFormEffortModifierTest < ActiveSupport::TestCase
  def setup
    @life_form = LifeForm.create!(name: "human")
    @modifier = @life_form.life_form_effort_modifier
  end

  test "should be valid" do
    assert @modifier.valid?
  end

  test "should belong to life form" do
    assert_respond_to @modifier, :life_form
    assert_equal @life_form, @modifier.life_form
  end

  test "should require all effort modifiers" do
    @modifier.basic_mod = nil
    assert_not @modifier.valid?

    @modifier.weapons_and_tools_mod = nil
    assert_not @modifier.valid?

    @modifier.guns_mod = nil
    assert_not @modifier.valid?

    @modifier.energy_and_magic_mod = nil
    assert_not @modifier.valid?

    @modifier.ultimate_mod = nil
    assert_not @modifier.valid?
  end

  test "should have correct default values" do
    assert_equal 0, @modifier.basic_mod
    assert_equal 0, @modifier.weapons_and_tools_mod
    assert_equal 0, @modifier.guns_mod
    assert_equal 0, @modifier.energy_and_magic_mod
    assert_equal 0, @modifier.ultimate_mod
  end
end
