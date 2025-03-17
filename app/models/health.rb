# frozen_string_literal: true

class Health
  MIN_HEALTH = 0

  attr_reader :max_health, :current_health

  def initialize(max_health: 10)
    @max_health = max_health
    @current_health = max_health
  end

  def take_damage(amount)
    return if amount.negative?

    @current_health = [ @current_health - amount, MIN_HEALTH ].max
  end

  def heal(amount)
    return if amount.negative?

    @current_health = [ @current_health + amount, @max_health ].min
  end

  def hearts
    (@max_health / 10.0).ceil
  end
end
