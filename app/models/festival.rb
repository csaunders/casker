class Festival < ActiveRecord::Base
  has_one :location

  validates :name, :website, presence: true
  validates :starts_at, numericality: { greater_than: Time.now.to_i }
end
