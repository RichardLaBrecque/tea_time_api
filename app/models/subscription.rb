class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  enum status: ["active", "canceled"]
  enum frequency: ["weekly", "monthly"]
end
