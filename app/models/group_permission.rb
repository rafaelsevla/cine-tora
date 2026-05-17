class GroupPermission < ApplicationRecord
  belongs_to :user_group

  validates :permission, presence: true, uniqueness: { scope: :user_group_id }
end
