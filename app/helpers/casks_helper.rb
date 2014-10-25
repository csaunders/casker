module CasksHelper
  def drinklist(cask)
    list = []
    list << {class: 'warning label', title: 'Favourite'} if attendee.favourite?(cask)
    list << {class: 'success label', title: 'Completed'} if attendee.consumed?(cask)
    list << {class: 'secondary label', title: 'To Drink'} if attendee.to_consume?(cask)
    list
  end

  def cache_key_for_cask(cask)
    drink = attendee.find_drink_for(cask)
    key_attributes = {
      attendee: attendee.id,
      cask: cask.id,
      drink: drink.id,
      state: drink.state
    }
    key_attributes.reduce(""){ |memo, (k, v)| memo + "#{k}:#{v}" }
  end
end
