# Create all player types
PlayerType::TYPES.each do |type|
  PlayerType.find_or_create_by!(name: type)
end
