class Role < ActiveRecord::Base
  ADMIN = "admin"
  COLLABORATOR = "collaborator"
  USER = "user"
  ROLES = [ADMIN, COLLABORATOR, USER]
  belongs_to :user
  validates :name, inclusion: {in: ROLES}

  scope :admin, -> { where(name: ADMIN) }
  scope :collaborator, -> { where(name: COLLABORATOR) }
end
