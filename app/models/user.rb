class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :user_has_user_groups, dependent: :destroy
  has_many :user_groups, through: :user_has_user_groups
  has_many :permissions, through: :user_groups, source: :group_permissions

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def has_permission?(permission)
    permissions.exists?(permission: permission)
  end

  def admin?
    has_permission?("admin_access")
  end
end
