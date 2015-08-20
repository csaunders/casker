class Beer < ActiveRecord::Base
  belongs_to :style, class: 'BeerStyle'
  belongs_to :brewery
  validates :name, :brewery, :style, presence: true
  validates :abv, :ibu, :srm, :fg, numericality: { greater_than: 0 }
end
