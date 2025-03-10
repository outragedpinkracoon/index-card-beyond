require_relative "../test_helper"

class PlayerTypeTest < ActiveSupport::TestCase
  test "can create valid player types" do
    PlayerType::TYPES.each do |type|
      player_type = PlayerType.new(name: type)
      assert player_type.valid?, "#{type} should be a valid player type"
    end
  end

  test "cannot create player type with invalid name" do
    player_type = PlayerType.new(name: "invalid_type")
    assert_not player_type.valid?
    assert_includes player_type.errors[:name], "is not included in the list"
  end

  test "name cannot be blank" do
    player_type = PlayerType.new(name: "")
    assert_not player_type.valid?
    assert_includes player_type.errors[:name], "can't be blank"
  end

  test "name cannot be nil" do
    player_type = PlayerType.new(name: nil)
    assert_not player_type.valid?
    assert_includes player_type.errors[:name], "can't be blank"
  end
end
