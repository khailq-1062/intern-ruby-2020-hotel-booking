class Room < ApplicationRecord
  belongs_to :category

  scope :search_by_name, (lambda do |name|
    where "LOWER(name) LIKE ?", "%#{name.downcase}%" if name.present?
  end)

  scope :search_by_price, (lambda do |price|
    where "price <= ?", price if price.present?
  end)

  scope :top_hired, ->{order hired: Settings.model.order.desc}
end
