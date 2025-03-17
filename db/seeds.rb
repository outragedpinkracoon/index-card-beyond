# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
