class WishlistEntry < ActiveRecord::Base
  belongs_to :wishlist
  belongs_to :beer
end
