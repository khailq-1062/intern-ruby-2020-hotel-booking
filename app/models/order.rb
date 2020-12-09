class Order < ApplicationRecord
  ORDER_PARAMS = [
    :note,
    :room_id,
    :date_start,
    :date_end,
    :quantity_person,
    :price,
    :status_id,
    booking_attributes: Booking::BOOKING_PARAMS
  ].freeze

  belongs_to :user
  belongs_to :room
  has_one :booking, dependent: :destroy
  belongs_to :status

  validates :date_start, :date_end, presence: true
  validate :validate_date_booking
  validates :quantity_person, numericality: {only_integer: true}
  validates :note, length: {maximum: Settings.model.validate.max_length_note}

  delegate :name, :address, :price, to: :room, prefix: true
  delegate :name, to: :status, prefix: true

  accepts_nested_attributes_for :booking,
                                reject_if: :all_blank,
                                allow_destroy: true

  after_save :send_mail_create_order

  scope :order_id_desc, ->{order id: :desc}
  scope :order_status_asc, ->{order status_id: :asc}

  def send_mail_create_order
    OrderMailer.create_order(user, self).deliver_now
  end

  def validate_date_booking
    return if date_start.blank? || date_end.blank?

    return unless date_end < date_start

    errors.add(:date_end, I18n.t("date_end_must_after_date_start"))
  end
end
