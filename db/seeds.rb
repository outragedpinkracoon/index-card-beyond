# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Only run seeds in development environment
unless Rails.env.development?
  puts "Seeds can only be run in development environment"
  exit
end

puts "Cleaning up existing data in development environment..."

# Delete in order of dependencies (most dependent first)
Player.delete_all
Equipment.delete_all
LifeFormEffortModifier.delete_all
LifeFormAttributeModifier.delete_all
LifeForm.delete_all
PlayerType.delete_all

puts "Cleanup completed!"

# Create all player types
PlayerType::TYPES.each do |type|
  PlayerType.find_or_create_by!(name: type)
end

# Create life forms with their attribute modifiers
life_forms = [
  {
    name: 'human',
    attribute_modifiers: {
      str_mod: 0,
      dex_mod: 0,
      con_mod: 0,
      int_mod: 1,
      wis_mod: 0,
      cha_mod: 1
    },
    effort_modifiers: {
      basic_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    }
  },
  {
    name: 'elf',
    attribute_modifiers: {
      str_mod: 0,
      dex_mod: 1,
      con_mod: -1,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    },
    effort_modifiers: {
      basic_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 1,
      ultimate_mod: 0
    }
  },
  {
    name: 'dwarf',
    attribute_modifiers: {
      str_mod: 0,
      dex_mod: -1,
      con_mod: 1,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    },
    effort_modifiers: {
      basic_mod: 0,
      weapons_and_tools_mod: 1,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    }
  },
  {
    name: 'gerblin',
    attribute_modifiers: {
      str_mod: -1,
      dex_mod: 1,
      con_mod: 0,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    },
    effort_modifiers: {
      basic_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    }
  },
  {
    name: 'torton',
    attribute_modifiers: {
      str_mod: 1,
      dex_mod: -1,
      con_mod: 1,
      int_mod: 0,
      wis_mod: 0,
      cha_mod: 0
    },
    effort_modifiers: {
      basic_mod: 0,
      weapons_and_tools_mod: 0,
      guns_mod: 0,
      energy_and_magic_mod: 0,
      ultimate_mod: 0
    }
  }
]

life_forms.each do |life_form_data|
  # Create or find the life form
  life_form = LifeForm.find_or_create_by!(name: life_form_data[:name])

  # Create or update attribute modifiers
  if life_form.life_form_attribute_modifier
    life_form.life_form_attribute_modifier.update!(life_form_data[:attribute_modifiers])
  else
    life_form.create_life_form_attribute_modifier!(life_form_data[:attribute_modifiers])
  end

  # Create or update effort modifiers
  if life_form.life_form_effort_modifier
    life_form.life_form_effort_modifier.update!(life_form_data[:effort_modifiers])
  else
    life_form.create_life_form_effort_modifier!(life_form_data[:effort_modifiers])
  end
end

# Equipment Seeds
puts "Creating equipment..."

# Weapons
Equipment.create!(
  name: 'Iron Sword',
  description: 'A reliable iron sword, well-balanced and sharp',
  str_mod: 1,
  weapons_and_tools_mod: 2,
  defense_mod: 1,
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

Equipment.create!(
  name: 'Wooden Shield',
  description: 'A sturdy wooden shield reinforced with iron bands',
  str_mod: 0,
  dex_mod: 0,
  con_mod: 1,
  int_mod: 0,
  wis_mod: 0,
  cha_mod: 0,
  basic_mod: 0,
  weapons_and_tools_mod: 0,
  guns_mod: 0,
  energy_and_magic_mod: 0,
  ultimate_mod: 0,
  defense_mod: 3
)

Equipment.create!(
  name: 'Magic Staff',
  description: 'A wooden staff imbued with magical energy',
  str_mod: 0,
  dex_mod: 0,
  con_mod: 0,
  int_mod: 2,
  wis_mod: 1,
  cha_mod: 0,
  basic_mod: 0,
  weapons_and_tools_mod: 0,
  guns_mod: 0,
  energy_and_magic_mod: 3,
  ultimate_mod: 0,
  defense_mod: 1
)

Equipment.create!(
  name: 'Leather Armor',
  description: 'Light and flexible leather armor',
  str_mod: 0,
  dex_mod: 1,
  con_mod: 1,
  int_mod: 0,
  wis_mod: 0,
  cha_mod: 0,
  basic_mod: 1,
  weapons_and_tools_mod: 0,
  guns_mod: 0,
  energy_and_magic_mod: 0,
  ultimate_mod: 0,
  defense_mod: 2
)

Equipment.create!(
  name: 'Energy Pistol',
  description: 'A sleek pistol that fires energy bolts',
  str_mod: 0,
  dex_mod: 1,
  con_mod: 0,
  int_mod: 1,
  wis_mod: 0,
  cha_mod: 0,
  basic_mod: 0,
  weapons_and_tools_mod: 0,
  guns_mod: 2,
  energy_and_magic_mod: 1,
  ultimate_mod: 0,
  defense_mod: 0
)

Equipment.create!(
  name: 'Ring of Protection',
  description: 'A silver ring that enhances defensive capabilities',
  str_mod: 0,
  dex_mod: 0,
  con_mod: 1,
  int_mod: 0,
  wis_mod: 0,
  cha_mod: 0,
  basic_mod: 0,
  weapons_and_tools_mod: 0,
  guns_mod: 0,
  energy_and_magic_mod: 0,
  ultimate_mod: 0,
  defense_mod: 2
)

Equipment.create!(
  name: 'Amulet of Power',
  description: 'An ancient amulet that enhances all combat abilities',
  str_mod: 1,
  dex_mod: 1,
  con_mod: 1,
  int_mod: 0,
  wis_mod: 0,
  cha_mod: 0,
  basic_mod: 1,
  weapons_and_tools_mod: 1,
  guns_mod: 1,
  energy_and_magic_mod: 1,
  ultimate_mod: 1,
  defense_mod: 1
)

Equipment.create!(
  name: 'Ultimate Gauntlet',
  description: 'A powerful gauntlet that channels ultimate energy',
  str_mod: 2,
  dex_mod: 0,
  con_mod: 1,
  int_mod: 0,
  wis_mod: 0,
  cha_mod: 0,
  basic_mod: 0,
  weapons_and_tools_mod: 0,
  guns_mod: 0,
  energy_and_magic_mod: 0,
  ultimate_mod: 3,
  defense_mod: 1
)

puts "Equipment creation completed!"

# Player Seeds
puts "Creating players..."

# Helper method to distribute attribute points
def distribute_points(focus)
  points = { str: 0, dex: 0, con: 0, int: 0, wis: 0, cha: 0 }
  remaining = 6

  # Allocate 2 points to primary stat
  points[focus] = 2
  remaining -= 2

  # Distribute remaining points randomly among other stats
  other_stats = points.keys - [ focus ]
  remaining.times do
    stat = other_stats.sample
    points[stat] += 1
  end

  points
end

# Create some example players
[
  {
    name: "Thorgrim Stonefist",
    world: "The Shattered Realms",
    story: "A dwarf warrior who left his mountain home to seek glory in battle.",
    life_form: "dwarf",
    player_type: "warrior",
    focus: :str,
    max_health: 12
  },
  {
    name: "Aelindra Moonshadow",
    world: "The Shattered Realms",
    story: "An elven mystic who studies the ancient arts of energy manipulation.",
    life_form: "elf",
    player_type: "mage",
    focus: :int,
    max_health: 8
  },
  {
    name: "Zix the Quick",
    world: "The Shattered Realms",
    story: "A nimble gerblin scout who moves silently through the shadows.",
    life_form: "gerblin",
    player_type: "shadow",
    focus: :dex,
    max_health: 8
  },
  {
    name: "Marcus Valerius",
    world: "The Shattered Realms",
    story: "A charismatic human bard who inspires others with tales of heroism.",
    life_form: "human",
    player_type: "bard",
    focus: :cha,
    max_health: 10
  },
  {
    name: "Gronak Shellback",
    world: "The Shattered Realms",
    story: "A torton priest who uses divine magic to protect and heal others.",
    life_form: "torton",
    player_type: "priest",
    focus: :wis,
    max_health: 15
  }
].each do |player_data|
  # Get the life form and player type
  life_form = LifeForm.find_by!(name: player_data[:life_form])
  player_type = PlayerType.find_by!(name: player_data[:player_type])

  # Distribute attribute points based on focus
  attrs = distribute_points(player_data[:focus])

  # Create the player
  player = Player.create!(
    name: player_data[:name],
    world: player_data[:world],
    story: player_data[:story],
    life_form: life_form,
    player_type: player_type,
    base_str: attrs[:str],
    base_dex: attrs[:dex],
    base_con: attrs[:con],
    base_int: attrs[:int],
    base_wis: attrs[:wis],
    base_cha: attrs[:cha],
    max_health: player_data[:max_health]
  )

  puts "Created player: #{player.name}"
end
