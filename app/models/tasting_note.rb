class TastingNote < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :drink
end
