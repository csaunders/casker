class Brewery < ActiveRecord::Base
  has_many :beers
  validates :name, :website, :location, presence: true
end
