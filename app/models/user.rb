class User < ApplicationRecord
  USER_PERMIT = %i(name email password password_confirmation).freeze

  has_many :orders, dependent: :destroy

  validates :name, presence: true,
                   length: {maximum: Settings.model.validate.max_name_user}
  validates :email, presence: true,
                    length: {maximum: Settings.model.validate.max_email_user},
                    format: {with: Settings.model.validate.valid_email_regex},
                    uniqueness: true
  validates :password, presence: true,
                       length: {minimum: Settings.model.validate.min_password},
                       allow_nil: true
  enum role: {user: 0, admin: 1}
  has_secure_password
end
