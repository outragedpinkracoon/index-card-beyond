class PlayerType < ApplicationRecord
  TYPES = %w[shadow bard hunter warrior mage priest].freeze

  validates :name, presence: true, inclusion: { in: TYPES }
end
