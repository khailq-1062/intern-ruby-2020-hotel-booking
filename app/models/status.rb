class Status < ApplicationRecord
  has_many :orders, dependent: :destroy
end
