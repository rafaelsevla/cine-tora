class UserGroup < ApplicationRecord
  has_many :user_has_user_groups, dependent: :destroy
  has_many :users, through: :user_has_user_groups
  has_many :group_permissions, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def has_permission?(permission)
    group_permissions.exists?(permission: permission)
  end
end
