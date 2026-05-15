class Room < ApplicationRecord
  belongs_to :theater
  belongs_to :room_model
end
