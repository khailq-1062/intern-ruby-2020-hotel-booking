class Room < ApplicationRecord
  belongs_to :category
  has_many :room_supplies, dependent: :destroy
  has_many :supplies, through: :room_supplies

  scope :search_by_name, (lambda do |name|
    where "LOWER(name) LIKE ?", "%#{name.downcase}%" if name.present?
  end)

  scope :search_by_price, (lambda do |price|
    where "price <= ?", price if price.present?
  end)

  scope :top_hired, ->{order hired: Settings.model.order.desc}
  scope :relate_room, (lambda do |category_id|
    where category_id: category_id if category_id.present?
  end)
  scope :random_room, ->{order "RAND()"}
end
