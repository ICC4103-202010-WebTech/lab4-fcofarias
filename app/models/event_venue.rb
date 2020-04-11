class EventVenue < ApplicationRecord
  has_many :events
  validates :name, presence: true
  validates :address, presence: true
  validates :capacity, numericality: { only_integer: true }
  validates :capacity, length: { minimum: 10 }
end
