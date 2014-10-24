module CasksHelper
  def drinklist(cask)
    list = []
    list << {class: 'warning label', title: 'Favourite'} if attendee.favourite?(cask)
    list << {class: 'success label', title: 'Completed'} if attendee.consumed?(cask)
    list << {class: 'secondary label', title: 'To Drink'} if attendee.to_consume?(cask)
    list
  end
end
