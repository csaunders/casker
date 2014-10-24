class Drink < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :cask

  default_scope { order(:cask_id)}

  delegate :name, :abv, :style, :brewery, :region, to: :cask

  def cask_number
    cask.cask
  end

  paginates_per 50
end
