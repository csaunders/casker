class Attendee < ActiveRecord::Base
  has_many :drinks, dependent: :destroy

  def favourite?(cask)
    drink = find_drink_for(cask)
    drink.favourite?
  end

  def consumed?(cask)
    drink = find_drink_for(cask)
    drink.done?
  end

  def listed?(cask)
    find_drink_for(cask).persisted?
  end

  def to_consume?(cask)
    listed?(cask) && !consumed?(cask)
  end

  def find_drink_for(cask)
    drinks_cache[cask.id] || Drink.new
  end

  private

  def drinks_cache
    @drinks_cache ||= drinks.reduce({}) do |cache, drink|
      cache[drink.cask_id] = drink
      cache
    end
  end
end
