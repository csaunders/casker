class Wishlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :festival
  has_many :entries, class: 'WishlistEntry', on_delete: :destroy
end
