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
    drinks.find_by(cask_id: cask.id).present?
  end

  def to_consume?(cask)
    listed?(cask) && !consumed?(cask)
  end

  def find_drink_for(cask)
    drinks.find_by(cask_id: cask.id) || Drink.new
  end
end
