module ApplicationHelper
  def class_for(section)
    active?(section) ? "active" : ""
  end

  def toggle_favourite(cask)
    drink = attendee.find_drink_for(cask)
    if drink.persisted?
      msg = drink.favourite? ? 'Unfavourite' : 'Favourite'
      link_to(msg, toggle_favourite_drink_path(drink, return: true), method: 'put', class: 'button')
    end
  end

  def toggle_consumed(cask)
    drink = attendee.find_drink_for(cask)
    if drink.persisted?
      msg = drink.done? ? "Mark as Incomplete" : "Mark as Completed"
      link_to(msg, toggle_completed_drink_path(drink, return: true), method: 'put', class: 'button')
    end
  end
end
