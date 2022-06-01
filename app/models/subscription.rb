class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  enum status: ["pending", "active", "canceled"]
end
