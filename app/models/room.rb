class Room < ApplicationRecord
  ROOM_PERMIT = %i(name slug category_id price ward_id
                   max_person description map image).freeze

  belongs_to :category
  has_many :room_supplies, dependent: :destroy
  has_many :supplies, through: :room_supplies

  validates :name, :slug, :price, :description, :map, :image, presence: true
  validates :price, :max_person,
            numericality: {greater_than: Settings.rooms.min_num}

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

  delegate :name, to: :category, prefix: true
end
