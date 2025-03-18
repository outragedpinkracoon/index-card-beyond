require "test_helper"

class PlayerEquipmentTest < ActiveSupport::TestCase
  def setup
    @player = players(:one)
    @equipment = equipment(:iron_sword)
    @player_equipment = PlayerEquipment.new(
      player: @player,
      equipment: @equipment
    )
  end

  test "should be valid" do
    assert @player_equipment.valid?
  end

  test "should require player" do
    @player_equipment.player = nil
    assert_not @player_equipment.valid?
  end

  test "should require equipment" do
    @player_equipment.equipment = nil
    assert_not @player_equipment.valid?
  end

  test "should allow a player to have multiple equipment" do
    @player_equipment.save
    second_equipment = equipment(:wooden_shield)
    second_player_equipment = PlayerEquipment.new(
      player: @player,
      equipment: second_equipment
    )
    assert second_player_equipment.valid?
  end

  test "should allow equipment to be used by multiple players" do
    @player_equipment.save
    second_player = players(:two)
    second_player_equipment = PlayerEquipment.new(
      player: second_player,
      equipment: @equipment
    )
    assert second_player_equipment.valid?
  end

  test "should destroy join record when player is destroyed" do
    # Clear any existing associations
    PlayerEquipment.delete_all

    @player_equipment.save
    assert_equal 1, PlayerEquipment.count, "Should have exactly one player_equipment record"
    assert_difference("PlayerEquipment.count", -1) do
      @player.destroy
    end
  end

  test "should destroy join record when equipment is destroyed" do
    # Clear any existing associations
    PlayerEquipment.delete_all

    @player_equipment.save
    assert_equal 1, PlayerEquipment.count, "Should have exactly one player_equipment record"
    assert_difference("PlayerEquipment.count", -1) do
      @equipment.destroy
    end
  end
end
