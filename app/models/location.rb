class Location < ActiveRecord::Base
  validate :city, :country, presence: true
end
