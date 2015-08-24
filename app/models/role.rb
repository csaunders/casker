class Role < ActiveRecord::Base
  ADMIN = "admin"
  USER = "user"
  ROLES = [ADMIN, USER]
  belongs_to :user
  validates :name, inclusion: {in: ROLES}

  scope :admin, -> { where(name: ADMIN) }
end
