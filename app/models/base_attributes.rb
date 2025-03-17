# frozen_string_literal: true

class BaseAttributes
  class StatsError < StandardError; end
  attr_reader :str, :dex, :con, :int, :wis, :cha

  MAX_POINTS = 6

  def initialize(str:, dex:, con:, int:, wis:, cha:)
    @str = str
    @dex = dex
    @con = con
    @int = int
    @wis = wis
    @cha = cha

    validate_stats
  end

  private

  def total
    str + dex + con + int + wis + cha
  end

  def validate_stats
    raise StatsError, "Stats are too low - must add to 6" if total < 6
    raise StatsError, "Stats are too high - must add to 6" if total > 6
  end
end
