class Supply < ApplicationRecord
  has_many :room_supplies, dependent: :destroy
  has_many :rooms, through: :room_supplies
end
