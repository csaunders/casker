class Role < ActiveRecord::Base
  ADMIN = "admin"
  USER = "user"
  ROLES = [ADMIN, USER]
  belongs_to :user
  validates :name, in: ROLES
end
