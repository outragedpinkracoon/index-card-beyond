class PlayerEquipment < ApplicationRecord
  belongs_to :player
  belongs_to :equipment
end
